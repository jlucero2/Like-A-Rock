class VotesController < ApplicationController
  
  def create
    @vote = Vote.new
    @vote.image = Image.find(params[:vote][:image_id])
    if user_signed_in?
      @vote.user = current_user
    else
       @vote.user = User.where(:ip => request.remote_ip).first
    end
    
    respond_to do |format|
      if @vote.save
        format.html { redirect_to album_image_path(@vote.image.album, @vote.image), notice: 'Vote was successfully created.' }
      else
        format.html { redirect_to album_image_path(@vote.image.album, @vote.image), notice: 'Vote was unsucessful.' }
      end
    end
  end
end
