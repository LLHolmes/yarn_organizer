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
      tool = Accessory.new(params[:name])
      tool.project = Project.find(params[:project])
      if tool.save
        redirect "/accessories/#{tool.id}"
      end
    end
    flash.now[:error] = "Something went wrong.  Please try again."
    redirect '/accessories/new'
  end

  # get '/accessories/:id' do
  #   @project = Project.find(params[:id])
  #   erb :"accessories/show_accessory"
  # end
  #
  # get '/accessories/:id/edit' do
  #   @project = Project.find(params[:id])
  #   if current_user == @project.user
  #     erb :"accessories/edit_accessory"
  #   end
  #   flash.next[:error] = "You may not edit other crafter's projects."
  #   redirect '/accessories'
  # end
  #
  # patch '/accessories/:id' do
  #   @project = Project.find(params[:id])
  #   if current_user == @project.user
  #     params.delete('_method')
  #     @project.update(params)
  #     redirect "/accessories/#{@project.id}"
  #   end
  #   flash.now[:error] = "You may not edit other crafter's projects."
  #   redirect '/accessories'
  # end
  #
  # delete '/accessories/:id/delete' do
  #   @project = Project.find(params[:id])
  #   if current_user == @project.user
  #     # yarn = @project.yarns
  #     # yarn.project = @project.user.stash
  #     @project.delete
  #   else
  #     flash.now[:error] = "You may not delete other crafter's projects."
  #   end
  #   redirect '/accessories'
  # end

end
