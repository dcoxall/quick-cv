# encoding: utf-8
require 'ostruct'

class EmploymentPresenter
  include Enumerable

  def initialize(employment_data)
    if employment_data != nil && employment_data.is_a?(Hash) && employment_data['values'] != nil
      @data = employment_data['values'].collect { |position| PositionPresenter.new(position) }
    else
      @data = []
    end
  end

  def each(&block)
    @data.each(&block)
  end

end
