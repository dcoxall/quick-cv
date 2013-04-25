# encoding: utf-8
require "date"

class CertificationPresenter
  attr_reader :name, :authority, :number, :date_range

  def initialize(data_hash = {})
    @name = data_hash['name']
    @authority = data_hash['authority']
    @number = data_hash['number'].to_s
    @date_range = build_date_range(data_hash['startDate'], data_hash['endDate'])
  end

  private

  def build_date_range(start_date_hash, end_date_hash)
    return nil if start_date_hash.nil?
    result = [format_date(start_date_hash['year'], start_date_hash['month'])]
    result << (end_date_hash.nil? ? "Current" : format_date(end_date_hash['year'], end_date_hash['month']))
    result
  end

  def format_date(year, month = nil)
    unless month.nil?
      month = Date::MONTHNAMES[month][0..2]
      "#{month} #{year}"
    else
      year
    end
  end
end
