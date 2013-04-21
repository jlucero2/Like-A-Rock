class TagsController < ApplicationController
  def index
     @image = Image.find(params[:image_id])
     
     if user_signed_in?
       @user = current_user
       @tags = @image.tags.where(:user_id => @user)
       respond_to do |format|
          format.html 
          format.js { redirect_to album_image_path(@image.album, @image)}
       end
     else
       flash[:notice] = "Must be signed in to see your tags."
       respond_to do |format|
          format.html 
         format.js { redirect_to album_image_path(@image.album, @image)}
       end
     end
   end

   def create
      @image = Image.find(params[:image_id])
      @newtag = @image.tags.new
      if user_signed_in?
        @newtag.user = current_user
      else
        @newtag.user = User.find_by_ip(request.remote_ip)
      end
      
      @newtag.x = params[:x]
      @newtag.y = params[:y]
      @newtag.save
      Rails.logger.warn '-'*40
      Rails.logger.warn @newtag.inspect
      respond_to do |format|
        if @newtag.save
            format.html { redirect_to album_image_path(@image.album, @image), notice: 'Tag was successfully created.' }
            format.js {redirect_to album_image_path(@image.album, @image)}
            format.json {redirect_to album_image_path(@image.album, @image)}
        else
            format.html 
            #format.js {redirect_to album_image_path(@image.album, @image)}
            format.json {redirect_to album_image_path(@image.album, @image)}
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
