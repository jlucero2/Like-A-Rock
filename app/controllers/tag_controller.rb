class TagController < ApplicationController
  def picture
    @image = Image.find(params[:tag][:image_id])
    @tags = @image.tags
    @tag = @image.tags.find(params[:id])
    @newtag = @image.tags.create(params[:tag])
    if user_signed_in?
      @user = current_user
    else
      @user = User.find_by_ip(request.remote_ip)
    end
    respond_to do |format|
      if @newtag.save
        format.html { redirect_to album_image_path(@image.album, @image), notice: 'tag was successfully created.' }
        format.js {render :layout => false}
      else
        format.html { album_image_path(@image.album, @image) }
        format.js {render :layout => false}
      end
  end
  
  def create
     @image = Image.find(params[:tag][:image_id])
     @newtag = @image.tags.new
     if user_signed_in?
       @newtag.user = current_user
     else
       @newtag.user = User.find_by_ip(request.remote_ip)
     end

    respond_to do |format|
      if @newtag.save
        format.html { redirect_to album_image_path(@image.album, @image), notice: 'Tag was successfully created.' }
        format.js {render :layout => false}
      else
        format.html { album_image_path(@image.album, @image) }
        format.js {render :layout => false}
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
