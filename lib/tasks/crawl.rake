# coding: utf-8
require "#{File.dirname(File.dirname(__FILE__))}/crawl.rb"

desc "OCWからクロール"
namespace :crawl do
  task :lecture => :environment do
    ActiveRecord::Base.transaction do
      #Crawl.department
      Crawl.section_and_course
    end
  end
end
