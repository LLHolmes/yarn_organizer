class CcessoriesController < ApplicationController

  get '/accessories' do
    erb :"accessories/index_accessories"
  end

  get '/accessories/new' do
    erb :"accessories/new_accessory"
  end

  post '/accessories/new' do
    if params[:name] == ""
      flash.now[:error] = "Please give your tool a name."
      redirect '/accessories/new'
    elsif Accessory.find_by_name(params[:name])
      flash.now[:warning] = "You already have a tool with that name. Please choose another."
      redirect '/accessories/new'
    else
      accessory = Accessory.new(params)
      if params[:project_id] == ""
        accessory.project = current_user.stash
      else
        accessory.project = Project.find(params[:project_id])
      end
      if accessory.save
        redirect "/accessories/#{accessory.id}"
      end
    end
    flash.now[:error] = "Something went wrong.  Please try again."
    redirect '/accessories/new'
  end

  get '/accessories/:id' do
    @accessory = Accessory.find(params[:id])
    erb :"accessories/show_accessory"
  end

  get '/accessories/:id/edit' do
    @accessory = Accessory.find(params[:id])
    if current_user == @accessory.user
      erb :"accessories/edit_accessory"
    end
    flash.next[:error] = "You may not edit other crafter's tools."
    redirect '/accessories'
  end

  patch '/accessories/:id' do
    @accessory = Accessory.find(params[:id])
    if current_user == @accessory.user
      params.delete('_method')
      @accessory.update(params)
      redirect "/accessories/#{@project.id}"
    end
    flash.now[:error] = "You may not edit other crafter's projects."
    redirect '/accessories'
  end

  # delete '/accessories/:id/delete' do
  #   @accessory = Accessory.find(params[:id])
  #   if current_user == @accessory.user
  #     # yarn = @project.yarns
  #     # yarn.project = @accessory.user.stash
  #     @accessory.delete
  #   else
  #     flash.now[:error] = "You may not delete other crafter's projects."
  #   end
  #   redirect '/accessories'
  # end

end
