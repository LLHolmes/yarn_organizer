class ProjectsController < ApplicationController

  get '/project/' do
    erb :"project/index_projects"
  end

  get '/project/new' do
    erb :"project/new_project"
  end

  post '/project/new' do
    # if params[:name] == "" || params[:email] == "" || params[:password] == ""
    #   flash.next[:error] = "Please fill out all fields."
    #   redirect '/signup'
    # elsif User.find_by_email(params[:email])
    #   flash.next[:warning] = "It looks like you're already a memeber of our community. Please log in."
    #   redirect '/login'
    # else
    #   user = User.new(params)
    #   if user.save
    #     session[:user_id] = user.id
    #     redirect '/'
    #   end
    # end
    # flash.next[:error] = "Something went wrong.  Please try again."
    # redirect '/signup'
  end

  get '/project/:id' do
    # if logged_in?
    #   erb :"user/account"
    # else
      redirect '/project/'
    # end
  end

  patch '/project/:id' do
    # user = User.find(params[:id])
    # user.name = params[:name] unless params[:name] == ""
    # user.email = params[:email] unless params[:email] == ""
    # user.password = params[:password] unless params[:password] == ""
    # user.save
    redirect "/project/:id"
  end

  delete '/project/:id/delete' do
    # if logged_in
    #   User.find(params[:id]).delete
    # end
    redirect '/project/'
  end

end
