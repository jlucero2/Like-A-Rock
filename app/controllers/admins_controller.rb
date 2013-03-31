class AdminsController < ApplicationController
  
  def index
    @admins = Admin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admins }
    end
  end

  def show
    @admin = Admin.find(params[:id])
    @responses = @admin.responses

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  
end
