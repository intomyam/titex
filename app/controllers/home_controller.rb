class HomeController < ApplicationController
  def index
    @course = Course.find_by(name: '知能情報コース')
  end
end
