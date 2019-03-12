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
    @project = Project.find(params[:id])
    erb :"project/show_project"
  end

  get '/projects/:id/edit' do
    @project = Project.find(params[:id])
    erb :"project/edit_project"
  end

  patch '/projects/:id' do
    @project = Project.find(params[:id])
    if current_user = @project.user
      params.delete('_method')
      @project.update(params)
      redirect "/projects/#{@project.id}"
    end
    flash.next[:error] = "You may not edit other crafter's projects."
    redirect '/projects'
  end

  delete '/projects/:id/delete' do
    @project = Project.find(params[:id])
    if current_user = @project.user
      # yarn = @project.yarns
      # yarn.project = @project.user.stash
      @project.delete
    else
      flash.next[:error] = "You may not delete other crafter's projects."
    end
    redirect '/projects'
  end

end
