# encoding: utf-8
class CollegePresenter
  attr_reader :qualification, :establishment, :date_range, :summary

  def initialize(data_hash = {})
    @qualification = [data_hash['degree'], data_hash['fieldOfStudy']].join(" ")
    @establishment = data_hash['schoolName']
    @date_range = build_date_range(data_hash['startDate'], data_hash['endDate'])
    @summary = data_hash['notes']
  end

  private

  def build_date_range(start_date_hash, end_date_hash)
    result = [format_date(start_date_hash['year'], start_date_hash['month'])]
    result << (end_date_hash.nil? ? "Current" : format_date(end_date_hash['year'], end_date_hash['month']))
    result
  end

  def format_date(year, month = nil)
    unless month.nil?
      month = Date::MONTHNAMES[month]
      "#{month} #{year}"
    else
      year
    end
  end
end
