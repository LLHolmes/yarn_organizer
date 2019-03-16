class YarnsController < ApplicationController

  get '/yarns' do
    if logged_in?
      erb :"yarns/index_yarns"
    else
      redirect '/login'
    end
  end

  get '/yarns/new' do
    if logged_in?
      erb :"yarns/new_yarn"
    else
      redirect '/login'
    end
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

  get '/yarns/new_bulk' do
    if logged_in?
      erb :"yarns/new_yarn_bulk"
    else
      redirect '/login'
    end
  end

  post '/yarns/new_bulk' do
    if params[:brand][:name] != ""
      @new_brand = Brand.create(params[:brand])
    end

    if params[:project][:name] != "" || params[:project][:pattern_info] != "" || params[:project][:notes] != ""
      if params[:project][:name] == ""
        flash.now[:warning] = "Your project was not saved. All projects need names."
      else
        @new_project = Project.new(params[:project])
        @new_project.user = current_user
        @new_project.save
      end
    end

    params[:yarn].each do |yarn_data|
      if !yarn_data[:color].empty?
        yarn = Yarn.new(yarn_data)
        if yarn_data[:brand_id].empty?
          yarn.brand = @new_brand
        end
        if yarn_data[:project_id].empty?
          yarn.project = @new_project
        end
        yarn.save
      elsif !yarn_data[:brand_id].empty? || !yarn_data[:count].empty?
        flash.now[:warning] = "Please specify a yarn color."
        redirect '/yarns/new_bulk'
      end
    end
    redirect "/yarns"
  end

  get '/yarns/:id' do
    if logged_in?
      @yarn = Yarn.find(params[:id])
      if current_user == @yarn.project.user
        erb :"yarns/show_yarn"
      else
        flash.next[:unauthorized] = "You may not view other crafter's yarn."
        redirect '/yarns'
      end
    else
      redirect '/login'
    end
  end

  get '/yarns/:id/edit' do
    if logged_in?
      @yarn = Yarn.find(params[:id])
      if current_user == @yarn.project.user
        erb :"yarns/edit_yarn"
      else
        flash.next[:unauthorized] = "You may not edit other crafter's yarn."
        redirect '/yarns'
      end
    else
      redirect '/login'
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
