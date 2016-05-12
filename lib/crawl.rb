class Crawl
  def self.section_and_course
    # 学部
    (0..7).each do |department_code|
      url = URI.parse('http://www.ocw.titech.ac.jp')
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.get('/index.php?module=General&action=T0100&GakubuCD=' + department_code.to_s)
      }

      doc = Nokogiri::HTML.parse(res.body)
      department = Department.find_or_create_by(code: department_code, name: doc.title[0..-18])

      doc.xpath('//*[@id="left-body-1"]/ul/li[contains(@class,"selected")]').css('ul').css('>li').each do |section_li|
        query_hash = Hash[URI::decode_www_form(section_li.at_css('a').attribute('href').value)]
        section_code = query_hash['KeiCD'] || query_hash['KamokuCD']
        Section.find_or_create_by(name: section_li.text,
                                  code: section_code,
                                  department: department,
                                  school_type: Section.school_types[:undergraduate],
                                  url: section_li.at_css('a').attribute('href').value)
      end
    end

    # 大学院
    (1..7).each do |department_code|
      url = URI.parse('http://www.ocw.titech.ac.jp')
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.get('/index.php?module=General&LeftTab=graduate&action=T0100&GakubuCD=' + department_code.to_s)
      }

      doc = Nokogiri::HTML.parse(res.body)
      department = Department.find_or_create_by(code: department_code, name: doc.title[0..-18])

      doc.xpath('//*[@id="left-body-2"]/ul/li[contains(@class,"selected")]').at_css('ul').css('>li').each do |section_li|
        if section_li.at_css('ul').nil? || section_li.at_css('ul').at_css('>li').nil?
          next unless section_li.at_css('a')

          query_hash = Hash[URI::decode_www_form(section_li.at_css('a').attribute('href').value)]
          section_code = query_hash['KamokuCD']
          Section.find_or_create_by(name: section_li.text,
                                    code: section_code,
                                    department: department,
                                    school_type: Section.school_types[:postgraduate],
                                    url: section_li.at_css('a').attribute('href').value)
          next
        end

        section_name = section_li.at_css('a').text
        code = section_li.attribute('id').value.sub('kei', '')
        section = Section.find_or_create_by(name: section_name,
                                            code: code,
                                            department: department,
                                            school_type: Section.school_types[:postgraduate])

        section_li.at_css('ul').css('li').each do |course_li|
          query_hash = Hash[URI::decode_www_form(course_li.at_css('a').attribute('href').value)]
          course_code = query_hash['course']
          course = Course.find_or_create_by(name: course_li.text,
                                            code: course_code)
          course.url = course_li.at_css('a').attribute('href').value
          course.save
          SectionCourse.find_or_create_by(section: section, course: course)
        end
      end
    end
  end


  def self.lecture
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
