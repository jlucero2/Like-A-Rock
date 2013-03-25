class AdminsController < ApplicationController
  
  def index
    @admins = Admin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admins }
    end
  end
  
end