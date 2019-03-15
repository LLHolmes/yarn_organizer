class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "i<3yarn"
    register Sinatra::Flash
  end

  get '/' do
    if logged_in?
      @lace = current_user.brand_by_weight("0")
      @sock = current_user.brand_by_weight("1")
      @fine = current_user.brand_by_weight("2")
      @light = current_user.brand_by_weight("3")
      @medium = current_user.brand_by_weight("4")
      @bulky = current_user.brand_by_weight("5")
      @super_bulky = current_user.brand_by_weight("6")
      @jumbo = current_user.brand_by_weight("7")
      @novelty = current_user.brand_by_weight("Novelty")
      erb :index
    else
      erb :"user/login"
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
