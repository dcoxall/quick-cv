# encoding: utf-8
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
        number['phoneType'].downcase == type.downcase
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
end
