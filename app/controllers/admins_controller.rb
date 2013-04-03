class AdminsController < ApplicationController
  
  def index
    @admins = Admin.all
    @images1 = Image.where(:responses_count => 0).order('votes_count DESC').all(:limit => 9)
    @images2 = Image.order('votes_count DESC').all(:limit => 9)
    @images3 = Image.where(:responses_count => 0).order('votes_count DESC').all(:limit => 9)
    


    respond_to do |format|
      format.html # index.html.erb after it's finished running the controller function
                  #index it looks for a file index.erb.html 
      format.json { render json: @admins } #index it looks for a file index.json 
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
