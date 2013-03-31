class AdminsController < ApplicationController
  
  def index
    @admins = Admin.all
    @images = Image.order('votes_count DESC').all(:limit => 15)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admins }
    end
    
  end
  #need a seperate column for count so that it doesn't have to go through every image every time. 
  #rails provides us with a way to update the vote count automatically.
end
