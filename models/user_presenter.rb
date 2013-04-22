# encoding: utf-8
require_relative "employment_presenter.rb"
require_relative "education_presenter.rb"
require_relative "skills_presenter.rb"

# FIXME: This feels wrong. I think the user model is incorrect.
#        The class isn't really user but APIConnection or something we
#        could then just pass the api data into this as opposed to the
#        object.

class UserPresenter
  def initialize(user_model)
    @model = user_model
  end

  def full_name
    "#{@model.data['firstName']} #{@model.data['lastName']}"
  end

  def phone_number(type = nil)
    if type.nil?
      @model.data['phoneNumbers']['values'][0]['phoneNumber']
    else
      number = @model.data['phoneNumbers']['values'].select do |number|
        number['phoneType'].downcase == type.to_s.downcase
      end
      number['phoneNumber']
    end
  end

  def address
    @model.data['mainAddress'].gsub("\n", " ")
  end

  def email_address
    @model.data['emailAddress']
  end

  def employment
    EmploymentPresenter.new(@model.data['positions'])
  end

  def education
    EducationPresenter.new(@model.data['educations'])
  end

  def skills
    SkillsPresenter.new(@model.data['skills'])
  end
end
