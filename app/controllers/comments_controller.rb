class CommentsController < ApplicationController
  respond_to :html, :js
  
  def create
    @image = Image.find(params[:comment][:image_id])
    if user_signed_in?
      @user = current_user
    else
      @user = User.find_by_ip(request.remote_ip)
    end
    @comment = Comment.new
    @comment.user = @user
    @comment.image = @image
    @comment.body = params[:comment][:body]
    #flash[:notice] = 'Comment was successfully created.' if @comment.save
    #respond_with(@comment, :location => album_image_path(@image.album, @image))
    respond_to do |format|
      if @comment.save
        @image.commented_at = Time.now;
        @image.save
        format.html { redirect_to album_image_path(@image.album, @image), notice: 'Question was successfully created.' }
      else
        format.html { redirect_to album_image_path(@image.album, @image), notice: 'Question was unsucessful.' }
      end
    end
  end
end