class TagController < ApplicationController
  def index
    @image = Image.find(params[:image_id])
    @tags = @image.tags
    @tag = @image.tags.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @albums }
      format.js {render :layout => false}
    end
  end
  
  def create
    @image = Image.find(params[:image_id])
    @tag = @image.tags.create(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to album_image_path(@album, @image), notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
        format.js {}
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def delete
    @image = Image.find(params[:image_id])
    @tag = @image.tags.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to album_images_url }
      format.json { head :no_content }
      format.js {}
    end
  end
end
