class BrandsController < ApplicationController

  get '/brands' do
    binding.pry
    @lace = current_user.brand_by_weight("0")
    @sock = current_user.brand_by_weight("1")
    @fine = current_user.brand_by_weight("2")
    @light = current_user.brand_by_weight("3")
    @medium = current_user.brand_by_weight("4")
    @bulky = current_user.brand_by_weight("5")
    @super_bulky = current_user.brand_by_weight("6")
    @jumbo = current_user.brand_by_weight("7")
    @novelty = current_user.brand_by_weight("Novelty")
    erb :"brands/index_brands"
  end

  get '/accessories/new' do
    erb :"accessories/new_accessory"
  end

  post '/accessories/new' do
    if params[:name] == "" || params[:status] == ""
      flash.now[:warning] = "Please fill out all information."
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
