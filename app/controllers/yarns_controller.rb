class YarnsController < ApplicationController

  get '/yarns' do
    erb :"yarns/index_yarns"
  end

  get '/yarns/new' do
    erb :"yarns/new_yarn"
  end

  post '/yarns/new' do
    if params[:yarn][:color] == ""
      flash.now[:warning] = "Please specify a yarn color."
      redirect '/accessories/new'
    elsif params[:yarn][:brand_id] == nil && params[:brand][:name] == ""
      flash.now[:warning] = "Please specify a brand."
      redirect '/accessories/new'
    else
      @yarn = Yarn.new(params[:yarn])
      if params[:yarn][:brand_id] == nil
        @brand = Brand.create(params[:brand])
        @yarn.brand = @brand
      end

      if params[:yarn][:project_id] == nil
        if params[:project][:name] != ""
          @project = Project.new(params[:project])
          @project.user = current_user
          @project.save
        else
          @project = current_user.stash
        end
        @yarn.project = @project
      end

      if @yarn.save
        redirect "/yarns/#{@yarn.id}"
      end
    end
    flash.now[:error] = "Something went wrong.  Please try again."
    redirect '/yarns/new'
  end

  get '/yarns/:id' do
    @yarn = Yarn.find(params[:id])
    if current_user == @yarn.project.user
      erb :"yarns/show_yarn"
    else
      flash.next[:unauthorized] = "You may not view other crafter's tools."
      redirect '/yarns'
    end
  end

  get '/yarns/:id/edit' do
    @yarn = Yarn.find(params[:id])
    if current_user == @yarn.project.user
      erb :"yarns/edit_yarn"
    else
      flash.next[:unauthorized] = "You may not edit other crafter's yarn."
      redirect '/yarns'
    end
  end

  patch '/yarns/:id' do
    @yarn = Yarn.find(params[:id])
    if current_user == @yarn.project.user
      params.delete('_method')
      @yarn.update(params)
      redirect "/yarns/#{@yarn.id}"
    end
    flash.now[:unauthorized] = "You may not edit other crafter's yarn."
    redirect '/yarns'
  end

  delete '/yarns/:id/delete' do
    @yarn = Yarn.find(params[:id])
    if current_user == @yarn.project.user
      @yarn.delete
    else
      flash.now[:unauthorized] = "You may not delete other crafter's yarn."
    end
    redirect '/yarns'
  end

end
