# encoding: utf-8
require 'ostruct'
require_relative "college_presenter.rb"

class EducationPresenter
  include Enumerable

  def initialize(education_data)
    if education_data != nil && education_data.is_a?(Hash) && education_data['values'] != nil
      @data = education_data['values'].collect { |college| CollegePresenter.new(college) }
    else
      @data = []
    end
  end

  def each(&block)
    @data.each(&block)
  end

end
