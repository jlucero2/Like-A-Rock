class VotesController < ApplicationController
  
  def create
    @vote = Vote.new
    @vote.user = current_user ? current_user.id.to_s : request.remote_ip.to_s
    @vote.image = Image.find(params[:vote][:image_id])
    
    respond_to do |format|
      if @vote.save
        format.html { redirect_to album_image_path(@vote.image.album, @vote.image), notice: 'Vote was successfully created.' }
      else
        format.html { redirect_to album_image_path(@vote.image.album, @vote.image), notice: 'Vote was unsucessful.' }
      end
    end
  end
end