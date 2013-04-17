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
    @image = Image.find(params[:response][:image_id])
    @response.body = params[:response][:body]
    @response.url = params[:response][:url]
    @response.image = @image
    @response.admin = Admin.find(params[:response][:admin_id])
    
    respond_to do |format|
      if @response.save
        @image.responded_at = Time.now;
        @image.save
        format.html { redirect_to album_image_path(@response.image.album, @response.image), notice: 'Response was successfully created.' }
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

  def index
    @responses = Response.all

    respond_to do |format|
	format.html # index.html.erb
	format.json { render json: @albums }
    end
  end
  
end
