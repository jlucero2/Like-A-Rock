class TagController < ApplicationController
  def picture
    @image = Image.find(params[:image_id])
    @tags = @image.tags
    @tag = @image.tags.find(params[:id])
    @newtag = @image.tags.create(params[:tag])
    if user_signed_in?
      @user = current_user
    else
      @user = User.find_by_ip(request.remote_ip)
    end
    respond_to do |format|
      if @image.save
        format.html { redirect_to album_image_path(@album, @image), notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
        format.js {render :layout => false}
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
        format.js {render :layout => false}
      end
  end
  
  def create
     @album = Album.find(params[:album_id])
     @image = @album.images.find(params[:id])
     @tags = @image.tags
     if user_signed_in?
       @user = current_user
     else
       @user = User.find_by_ip(request.remote_ip)
     end
     @tag = @tags.find_by_user_id_and_image_id(@user, @image)
     @newtag = @tags.create(params[:tag])

    respond_to do |format|
      if @image.save
        format.html { redirect_to album_image_path(@album, @image), notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
        format.js {render :layout => false}
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
      format.js {render :layout => false}
    end
  end
end
