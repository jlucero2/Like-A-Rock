class VotesController < ApplicationController
  
  def create
    #@vote = Vote.new
    @image = Image.find(params[:vote][:image_id])
    @vote = @image.votes.new
    if user_signed_in?
      @vote.user = current_user
    else
       @vote.user = User.find_by_ip(request.remote_ip)
    end
    
    respond_to do |format|
      if @vote.save
        format.html { redirect_to album_image_path(@image.album, @image), notice: 'Vote was successfully created.' }
      else
        format.html { redirect_to album_image_path(@image.album, @image), notice: 'Vote was unsucessful.' }
      end
    end
  end
end
