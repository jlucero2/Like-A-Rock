class ResponsesController < ApplicationController
  
  def new
    @response = Response.new
    @comment = Comment.find(params[:comment])
    @image = Image.find(params[:image])
    @admin = current_admin
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @response }
    end
  end
  
  def create
    @response = Response.new 
    
    @response.body = params[:response][:body]
    @response.image = Image.find(params[:response][:image_id])
    @response.admin = Admin.find(params[:response][:admin_id])
    
    respond_to do |format|
      if @response.save
        format.html { redirect_to @response, notice: 'Response was successfully created.' }
        format.json { render json: @response, status: :created, location: @response }
      else
        format.html { render action: "new" }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @response = Response.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @response}
    end
  end
  
end