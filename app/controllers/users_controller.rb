class UsersController < ApplicationController

  get '/login' do
    erb :"user/login"
  end

  get '/signup' do
    erb :"user/signup"
  end

  post '/signup' do
    if params[:name] == "" || params[:email] == "" || params[:password] == ""
      flash.next[:error] = "Please fill out all fields."
      redirect '/signup'
    elsif User.find_by_email(params[:email])
      flash.next[:warning] = "It looks like you're already a memeber of our community. Please log in."
      redirect '/login'
    else
      user = User.new(params)
      if user.save
        stash = Project.new(name: "Stash", status: "Perpetual")
        stash.user = user
        stash.save
        session[:user_id] = user.id
        redirect '/yarns/new_bulk'
      end
    end
    flash.next[:error] = "Something went wrong.  Please try again."
    redirect '/signup'
  end

  post '/login' do
    if params[:email] == "" || params[:password] == ""
      flash.next[:error] = "Please fill out all fields."
      redirect '/login'
    else
      user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/'
      end
    end
    redirect '/signup'
  end

  get '/account' do
    if logged_in?
      erb :"user/account"
    else
      redirect '/login'
    end
  end

  patch '/account/:id' do
    user = User.find(params[:id])
    user.name = params[:name] unless params[:name] == ""
    user.email = params[:email] unless params[:email] == ""
    user.password = params[:password] unless params[:password] == ""
    user.save
    redirect "/account"
  end

  delete '/account/:id/delete' do
    if logged_in?
      User.find(params[:id]).delete
      session.clear
    end
    redirect '/'
  end

  get '/logout' do
    session.clear
    flash.next[:logout] = "You've logged out."
    redirect '/'
  end

end
