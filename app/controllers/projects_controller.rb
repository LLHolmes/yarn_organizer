class ProjectsController < ApplicationController

  get '/projects' do
    @wip = current_user.projects_wip
    @upcoming = current_user.projects_upcoming
    @finished = current_user.projects_finished
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
      project.user = current_user
      if project.save
        redirect "/projects/#{project.id}"
      end
    end
    flash.next[:error] = "Something went wrong.  Please try again."
    redirect '/projects/new'
  end

  get '/projects/:id' do
    # if logged_in?
      erb :"project/show_project"
    # else
      # redirect '/projects/'
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
