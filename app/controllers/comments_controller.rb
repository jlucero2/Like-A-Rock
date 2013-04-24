class CommentsController < ApplicationController
  
  def create
    @image = Image.find(params[:comment][:image_id])
    if user_signed_in?
      @user = current_user
      @comments = Comment.where(:image_id => @image, :user_id => @user)
    else
      @user = User.find_by_ip(request.remote_ip)
    end
    @comment = Comment.new
    @comment.image = @image
    @comment.body = params[:comment][:body]
    @comment.user = @user
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to album_image_path(@image.album, @image), notice: 'Question was successfully created.' }
        format.js { render :layout => false}
      else
        format.html { redirect_to album_image_path(@image.album, @image), notice: 'Question was unsucessful.' }
        format.js { render :layout => false}
      end
    end
  end
end