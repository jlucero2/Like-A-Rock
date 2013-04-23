class ResponsesController < ApplicationController
  def newsticker
    @image = Image.find(params[:image_id])
    @response = @image.responses.find(params[:response_id])
    respond_to do |format|
        format.html # index.html.erb
        format.json 
    end
  end
  
  def create
    @image = Image.find(params[:response][:image_id])
    @admin = current_admin
    @newresponse = @image.responses.new 
    @newresponse.body = params[:response][:body]
    @newresponse.url = params[:response][:url]
    @newresponse.admin = @admin
    
    respond_to do |format|
      if @newresponse.save
        format.html {redirect_to admin_show_path(@image.album, @image)}
        format.js { render :layout => false}
        format.json
      else
        format.html {redirect_to admin_show_path(@image.album, @image)}
        format.json 
        format.js { render :layout => false}
      end
    end
  end
end
