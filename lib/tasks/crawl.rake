# coding: utf-8

desc "OCWからクロール"
namespace :crawl do
  task :lecture => :environment do
    ActiveRecord::Base.transaction do
      (1..7).each do |department_code|
        url = URI.parse('http://www.ocw.titech.ac.jp')
        res = Net::HTTP.start(url.host, url.port) {|http|
          http.get('/index.php?module=General&action=T0100&GakubuCD=' + department_code.to_s)
        }

        doc = Nokogiri::HTML.parse(res.body)
        department = Department.find_or_create_by(code: department_code, name: doc.title[0..-18])

        doc.xpath('//table[@class="ranking-list"]/tbody/tr').each do |kougi|
          subject_code = kougi.xpath('td[@class="code"]').text

          query_hash = Hash[URI::decode_www_form(kougi.xpath('td[@class="course_title"]/a/@href').first.value.match(/(?<=\?).+/).to_s)]
          department_code = query_hash['GakubuCD']
          section_code = query_hash['KeiCD'] || query_hash['KamokuCD']
          Section.find_or_create_by(code: section_code, department_id: department.id)
          course_code = query_hash['course']

          start = kougi.xpath('td[@class="start"]').text
          lecture_period = LecturePeriod.find_or_create_by(name: start)

          lecture_code = query_hash['KougiCD']
          lecture_name = kougi.xpath('td[@class="course_title"]').text.strip
          next unless lecture_code.present? || lecture_name.present? || subject_code.present?

          lecture = Lecture.find_or_create_by(code: lecture_code, name: lecture_name,
                                              subject_code: subject_code, department: department,
                                              lecture_period: lecture_period)

          query_hash = Hash[URI::decode_www_form(kougi.xpath('td[@class="opening_department"]/a/@href').first.value.match(/(?<=\?).+/).to_s)]
          course_code = query_hash['course']
          course_name = kougi.xpath('td[@class="opening_department"]').text.strip
          if course_code.present?
            course = Course.find_or_create_by(code: course_code, name: course_name)
            CourseLecture.find_or_create_by(course: course, lecture: lecture)
          end

          kougi.xpath('td[@class="lecturer"]/a').each do |lecturer|
            lecturer = Lecturer.find_or_create_by(code: lecturer[:href].match(/(?<=\=)\d+$/), name: lecturer.text)
            LectureLecturer.find_or_create_by(lecture: lecture, lecturer: lecturer)
          end
        end
      end
    end
  end
end
