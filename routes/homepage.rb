# encoding: utf-8
class QuickCVApp < Sinatra::Application
  before do
    options = {}
    options[:state] = session['user_state'].to_s
    options[:token] = session['token'].to_s
    @user = User.new(options)
  end

  get "/" do
    "Hello World"
  end

  get "/prepare" do
    session['user_state'] = @user.api_state
    session['token'] = nil
    redirect @user.authorize_url
  end

  get "/verify" do
    session['token'] = @user.validate(params[:code])
    redirect "/test"
  end

  get "/test" do
    @user.data # I just want to populate the data before the view
    @presenter = UserPresenter.new(@user)
    haml :table
  end
end
