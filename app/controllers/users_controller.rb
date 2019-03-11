class UsersController < ApplicationController

  get '/login' do
    erb :"user/login"
  end

  get '/signup' do
    # flash.now[:info] = "Please sign up."
    erb :"user/signup"
  end

  post '/signup' do
    if params.value? == ""
    # if params[:username] == "" || params[:email] == "" || params[:password] == ""
      flash.next[:error] = "Please fill out all fields."
      redirect '/signup'
    elsif User.find_by_email(params[:email])
      flash.next[:warning] = "It looks like you're already a memeber of our community. Please log in."
      redirect '/login'
    else
      user = User.new(params)
      if user.save
        session[:user_id] = user.id
        redirect '/'
      end
    end
    flash.next[:error] = "Something went wrong.  Please try again."
    redirect '/signup'
  end

  post '/login' do
    user = User.find_by_email(params[:email])
    if user
      session[:user_id] = user.id
      redirect '/'
    end
    flash.next[:error] = "Something went wrong.  Please try again."
    redirect '/login'
  end

  get '/account' do
    if logged_in?
      erb :"user/account"
    end
    redirect '/login'
  end

  # get '/account/:id' do
  #   if current_user.id == params[:id]
  #     erb :"user/account"
  #   end
  #   redirect '/login'
  # end

  patch '/account/:id' do
    if current_user.id == params[:id]
      user = User.find(params[:id])
      user.update(params)
      redirect "/account/#{user.id}"
    end
    flash.next[:error] = "You can only make changes to your account."
    redirect '/login'
  end

  delete '/account/:id' do
    if current_user.id == params[:id]
      User.find(params[:id]).destroy
    end
    redirect '/'
  end

  get '/logout' do
    session.clear
    flash.next[:logout] = "You've logged out."
    redirect '/'
  end

end
