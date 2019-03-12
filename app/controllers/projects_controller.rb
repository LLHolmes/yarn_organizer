class ProjectsController < ApplicationController

  get '/projects' do
    @wip = Project.status_wip(current_user.id)
    @upcoming = Project.status_upcoming(current_user.id)
    @finished = Project.status_finished(current_user.id)
    erb :"project/index_projects"
  end

  get '/projects/new' do
    erb :"project/new_project"
  end

  post '/projects/new' do
    if params[:name] == "" || params[:status] == ""
      flash.next[:error] = "A name and status are required to create a new project."
      redirect '/projects/new'
    elsif Project.find_by_name(params[:name])
      flash.next[:warning] = "You already have a project with that name. Please choose another."
      redirect '/projects/new'
    else
      project = Project.new(params)
      if project.save
        redirect "/projects/#{project.id}"
      end
    end
    flash.next[:error] = "Something went wrong.  Please try again."
    redirect '/projects/new'
  end

  get '/projects/:id' do
    # if logged_in?
    #   erb :"user/account"
    # else
      redirect '/projects'
    # end
  end

  patch '/projects/:id' do
    # user = User.find(params[:id])
    # user.name = params[:name] unless params[:name] == ""
    # user.email = params[:email] unless params[:email] == ""
    # user.password = params[:password] unless params[:password] == ""
    # user.save
    redirect "/projects/:id"
  end

  delete '/projects/:id/delete' do
    # if logged_in
    #   User.find(params[:id]).delete
    # end
    redirect '/projects'
  end

end
