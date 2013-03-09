class CommentsController < ApplicationController
  def create
    @image = Image.find(params[:image_id])
    @comment = @image.comments.create(params[:comment])
    @user = 1
    redirect_to image_path(@image)
  end
end
