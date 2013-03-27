class CommentsController < ApplicationController
  respond_to :html, :js
  
  def create
    @image = Image.find(params[:comment][:image_id])
    @user = current_user
    @comment = Comment.new
    @comment.user = @user
    @comment.image = @image
    @comment.body = params[:comment][:body]
    #flash[:notice] = 'Comment was successfully created.' if @comment.save
    #respond_with(@comment, :location => album_image_path(@image.album, @image))
    respond_to do |format|
      if @comment.save
        format.html { redirect_to album_image_path(@image.album, @image), notice: 'Question was successfully created.' }
      else
        format.html { redirect_to album_image_path(@image.album, @image), notice: 'Question was unsucessful.' }
      end
    end
  end
end