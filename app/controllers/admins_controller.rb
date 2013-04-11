class AdminsController < ApplicationController
  prepend_before_filter :authenticate
  
  def authenticate
    if !admin_signed_in?
      redirect_to root_path
    end
  end
  
  def new
    @admin = Admin.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def create
    @admin = Admin.new(params[:admin])

    respond_to do |format|
      if @admin.save
        format.html { redirect_to admins_path, notice: 'Admin was successfully created.' }
      else
        format.html { render action: "new", notice: 'Admin not saved' }
      end
    end
  end
  
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
