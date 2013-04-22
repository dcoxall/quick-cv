# encoding: utf-8
require_relative "employment_presenter.rb"
require_relative "education_presenter.rb"
require_relative "skills_presenter.rb"

class UserPresenter
  attr_reader :full_name, :address, :email_address, :employment, :education, :skills

  def initialize(data_hash)
    @full_name = [data_hash['firstName'], data_hash['lastName']].join(" ")
    if data_hash['phoneNumbers'] != nil && data_hash['phoneNumbers']['values'] != nil
      @phone_numbers = Hash.new
      data_hash['phoneNumbers']['values'].each { |p| @phone_numbers[p['phoneType'].downcase.to_sym] = p['phoneNumber'].to_s }
    end
    @address = data_hash['mainAddress'] && data_hash['mainAddress'].gsub("\n", " ")
    @email_address = data_hash['emailAddress']
    @employment = EmploymentPresenter.new(data_hash['positions'])
    @education = EducationPresenter.new(data_hash['educations'])
    @skills = SkillsPresenter.new(data_hash['skills'])
  end

  def phone_number(type = nil)
    type.nil? ? @phone_numbers.values[0] : @phone_numbers[type.to_s.downcase.to_sym]
  end
end
