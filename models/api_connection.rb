# encoding: utf-8
require "oauth2"
require "oj"
require "securerandom"

class APIConnection
  attr_accessor :api_state, :cache_client, :auth_token
  attr_reader :last_response

  def initialize(options = {})
    @api_state = options[:state] || SecureRandom.hex(15)
    @auth_token = options[:token] unless options[:token].nil?
    @cache_client = options[:cache_client]
  end

  def authorize_url
    api_client.auth_code.authorize_url(
      :scope => "r_fullprofile r_contactinfo r_emailaddress",
      :redirect_uri => "http://127.0.0.1:9393/verify",
      :state => api_state)
  end

  def authorized?
    !auth_token.nil?
  end

  def validate(code)
    token = api_client.auth_code.get_token(code, :redirect_uri => "http://127.0.0.1:9393/verify")
    auth_token = token.token
  end

  def data
    @data ||= populate_data
  end

  private

  def populate_data
    unless @cache_client && raw_data = @cache_client.get("profile_#{@api_state}")
      response = access_token.get("https://www.linkedin.com/v1/people/~:(first-name,last-name,email-address,specialties,positions,honors,interests,languages,skills,certifications,educations,courses,volunteer,phone-numbers,main-address)?format=json")
      raw_data = response.body
      @cache_client.set("profile_#{@api_state}", raw_data, 10 * 60, compress: true) if @cache_client
    end
    @data = Oj.load(raw_data)
  end

  def auth_token
    @auth_token
  end

  def access_token
    @access_token ||= OAuth2::AccessToken.new(api_client, auth_token, {
      :mode => :query,
      :param_name => "oauth2_access_token"})
  end

  def api_client
    @@api_client ||= OAuth2::Client.new(
      ENV['LINKEDIN_APP_KEY'],
      ENV['LINKEDIN_APP_SECRET'],
      :authorize_url => "/uas/oauth2/authorization?response_type=code",
      :token_url => "/uas/oauth2/accessToken",
      :site => "https://www.linkedin.com")
  end
end
