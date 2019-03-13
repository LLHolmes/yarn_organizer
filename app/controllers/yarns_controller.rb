class YarnsController < ApplicationController

  get '/yarns' do
    erb :"yarns/index_yarns"
  end

  get '/yarns/new' do
    erb :"yarns/new_yarn"
  end

  post '/yarns/new' do
    binding.pry
    if params[:yarn][:color] == ""
      flash.now[:warning] = "Please specify a yarn color."
      redirect '/accessories/new'
    elsif params[:yarn][:brand_id] == nil && params[:brand][:name] == ""
      flash.now[:warning] = "Please specify a brand."
      redirect '/accessories/new'


    #   Accessory.find_by_name(params[:name])
    #   flash.now[:warning] = "You already have a tool with that name. Please choose another."
    #   redirect '/accessories/new'
    # else
    #   accessory = Accessory.new(params)
    #   if params[:project_id] == ""
    #     accessory.project = current_user.stash
    #   else
    #     accessory.project = Project.find(params[:project_id])
    #   end
    #   if accessory.save
    #     redirect "/accessories/#{accessory.id}"
    #   end
    # end

    @yarn = Yarn.new(params[:yarn])
    if params[:yarn][:brand_id] == nil
      @brand = Brand.create(params[:brand])
      @yarn.brand = @brand
    end
    if params[:yarn][:project_id] == nil &&params[:project][:name] != ""
      @project = Project.create(params[:project])
      @yarn.project = @project
    end
    if @yarn.save
      redirect "/yarns/#{@yarn.id}"
    end

  end

  # get '/accessories/:id' do
  #   @accessory = Accessory.find(params[:id])
  #   if current_user == @accessory.project.user
  #     erb :"accessories/show_accessory"
  #   else
  #     flash.next[:unauthorized] = "You may not view other crafter's tools."
  #     redirect '/accessories'
  #   end
  # end
  #
  # get '/accessories/:id/edit' do
  #   @accessory = Accessory.find(params[:id])
  #   if current_user == @accessory.project.user
  #     erb :"accessories/edit_accessory"
  #   else
  #     flash.next[:unauthorized] = "You may not edit other crafter's tools."
  #     redirect '/accessories'
  #   end
  # end
  #
  # patch '/accessories/:id' do
  #   @accessory = Accessory.find(params[:id])
  #   if current_user == @accessory.project.user
  #     params.delete('_method')
  #     @accessory.update(params)
  #     redirect "/accessories/#{@accessory.id}"
  #   end
  #   flash.now[:unauthorized] = "You may not edit other crafter's projects."
  #   redirect '/accessories'
  # end
  #
  # delete '/accessories/:id/delete' do
  #   @accessory = Accessory.find(params[:id])
  #   if current_user == @accessory.project.user
  #     @accessory.delete
  #   else
  #     flash.now[:unauthorized] = "You may not delete other crafter's projects."
  #   end
  #   redirect '/accessories'
  # end

end
