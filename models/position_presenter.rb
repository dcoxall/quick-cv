# encoding: utf-8
require "date"

class PositionPresenter
  attr_reader :job_title, :company_name, :date_range, :responsibilities

  def initialize(data_hash = {})
    @job_title = data_hash['title']
    @company_name = data_hash['company']['name']
    @date_range = build_date_range(data_hash['startDate'], data_hash['endDate'], data_hash['isCurrent'])
    @responsibilities = data_hash['summary']
  end

  private

  def build_date_range(start_date_hash, end_date_hash, is_current = false)
    return nil if start_date_hash.nil?
    result = [format_date(start_date_hash['year'], start_date_hash['month'])]
    result << (is_current ? "Current" : format_date(end_date_hash['year'], end_date_hash['month']))
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
