# encoding: utf-8
require 'ostruct'

class EducationPresenter
  include Enumerable

  def initialize(education_data)
    @data = education_data['values'].collect do |college|
      CollegePresenter.new(college)
    end
  end

  def each(&block)
    @data.each(&block)
  end

end
