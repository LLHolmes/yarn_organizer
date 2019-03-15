class ProjectsController < ApplicationController

  get '/projects' do
    @wip = current_user.projects_wip
    @upcoming = current_user.projects_upcoming
    @finished = current_user.projects_finished
    erb :"projects/index_projects"
  end

  get '/projects/new' do
    erb :"projects/new_project"
  end

  post '/projects/new' do
    binding.pry
    if Project.find_by_name(params[:project][:name])
      flash.now[:warning] = "You already have a project with that name. Please choose another."
      redirect '/projects/new'
    else
      @project = Project.new(params[:project])
      @project.user = current_user
      if !!params[:yarns][:ids]
        yarns = params[:yarns][:ids]
        yarns.each do |ids|
          yarn = Yarn.find(ids)
          yarn.project = @project
          yarn.save
        end
      end
      if !!params[:accessories][:ids]
        accs = params[:accessories][:ids]
        accs.each do |ids|
          accessory = Accessory.find(ids)
          accessory.project = @project
          accessory.save
        end
      end
      if project.save
        redirect "/projects/#{project.id}"
      end
    end
    flash.now[:error] = "Something went wrong.  Please try again."
    redirect '/projects/new'
  end

  get '/projects/:id' do
    @project = Project.find(params[:id])
    erb :"projects/show_project"
  end

  get '/projects/:id/edit' do
    @project = Project.find(params[:id])
    if current_user != @project.user
      flash.next[:unauthorized] = "You may not edit other crafter's projects."
      redirect '/projects'
    end
    erb :"projects/edit_project"
  end

  patch '/projects/:id' do
    @project = Project.find(params[:id])
    if current_user != @project.user
      flash.now[:unauthorized] = "You may not edit other crafter's projects."
      redirect '/projects'
    end

    @project.update(params[:project])
    if !!params[:yarns][:ids]
      yarns = params[:yarns][:ids]
      yarns.each do |ids|
        yarn = Yarn.find(ids)
        yarn.project = @project
        yarn.save
      end
    end
    if !!params[:accessories][:ids]
      accs = params[:accessories][:ids]
      accs.each do |ids|
        accessory = Accessory.find(ids)
        accessory.project = @project
        accessory.save
      end
    end
    if @project.save
      if params[:status] == "Finished"
        redirect "/projects/#{@project.id}/finished_edit"
      else
        redirect "/projects/#{@project.id}"
      end
    end

    flash.now[:error] = "Something went wrong.  Please try again."
    redirect '/projects/new'
  end

  get '/projects/:id/finished_edit' do
    @project = Project.find(params[:id])
    if current_user != @project.user
      flash.next[:unauthorized] = "You may not edit other crafter's projects."
      redirect '/projects'
    end
    erb :"projects/edit_finished_project"
  end

  patch '/projects/:id/finished' do
    @project = Project.find(params[:id])
    if current_user != @project.user
      flash.now[:unauthorized] = "You may not edit other crafter's projects."
      redirect '/projects'
    else
      @project.update(status: "Finished")

      if @project.accessories
        @project.accessories.each do |acc|
          acc.project = current_user.stash
          acc.save
        end
      end

      params[:yarn].each do |yarn_data|
        yarn = Yarn.find(yarn_data[:id])
        yarn.update(yarn_data)
        yarn.project = current_user.stash
        yarn.save
      end

      if @project.save
        redirect "/projects"
      end
    end
    flash.now[:error] = "Something went wrong.  Please try again."
    redirect '/projects/new'
  end

  delete '/projects/:id/delete' do
    @project = Project.find(params[:id])
    if current_user != @project.user
      flash.now[:unauthorized] = "You may not delete other crafter's projects."
    else
      yarn = @project.yarns
      yarn.project = current_user.stash
      @project.delete
    end
    redirect '/projects'
  end

end
