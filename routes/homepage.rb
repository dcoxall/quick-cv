# encoding: utf-8
class QuickCVApp < Sinatra::Application
  before do
    options = {}
    options[:state] = session['user_state']
    options[:token] = session['token']
    options[:cache_client] = settings.cache_client
    @api = APIConnection.new(options)
  end

  get "/" do
    redirect "/prepare"
  end

  get "/prepare" do
    session['user_state'] = @api.api_state
    session['token'] = nil
    redirect @api.authorize_url
  end

  get "/verify" do
    session['token'] = @api.validate(params[:code])
    redirect "/test"
  end

  get "/test" do
    @presenter = UserPresenter.new(@api.fetch_data)
    haml :table
  end
end
