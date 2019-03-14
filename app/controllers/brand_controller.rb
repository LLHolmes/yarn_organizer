class BrandsController < ApplicationController

  get '/brands' do
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

  get '/brands/new' do
    erb :"brands/new_brand"
  end

  post '/brands/new' do
    if params[:name] == "" || params[:material] == "" || params[:weight] == ""
      flash.now[:warning] = "Please fill out all information."
      redirect '/brands/new'
    elsif Brand.find_by_name(params[:name])
      flash.now[:warning] = "You already have a brand with that name. Please choose another."
      redirect '/brands/new'
    else
      brand = Brand.new(params)
      if brand.save
        redirect "/brands/#{brand.id}"
      end
    end
    flash.now[:error] = "Something went wrong.  Please try again."
    redirect '/brands/new'
  end

  get '/brands/:id' do
    @brand = Brand.find(params[:id])
    @brand_yarns = current_user.brand_yarns(@brand)
    if current_user.brands.include?(@brand)
      erb :"brands/show_brand"
    else
      flash.next[:unauthorized] = "You may not view other crafter's brands."
      redirect '/brands'
    end
  end

  get '/brands/:id/edit' do
    @brand = Brand.find(params[:id])
    if current_user.brands.include?(@brand)
      erb :"brands/edit_brand"
    else
      flash.next[:unauthorized] = "You may not edit other crafter's brands."
      redirect '/brands'
    end
  end

  patch '/brands/:id' do
    @brand = Brand.find(params[:id])
    if current_user.brands.include?(@brand)
      params.delete('_method')
      @brand.update(params)
      redirect "/brands/#{@brand.id}"
    end
    flash.now[:unauthorized] = "You may not edit other crafter's brands."
    redirect '/brand'
  end

  delete '/brands/:id/delete' do
    @brand = Brand.find(params[:id])
    if current_user.brands.include?(@brand)
      @brand.delete
    else
      flash.now[:unauthorized] = "You may not delete other crafter's brands."
    end
    redirect '/brands'
  end

end
