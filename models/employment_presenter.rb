# encoding: utf-8
require 'ostruct'

class EmploymentPresenter
  include Enumerable

  def initialize(employment_data)
    @data = employment_data['values'].collect do |position|
      PositionPresenter.new(position)
    end
  end

  def each(&block)
    @data.each(&block)
  end

end
