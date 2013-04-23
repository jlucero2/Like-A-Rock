class ImagesController < ApplicationController
  def adminShow
    @album = Album.find(params[:album_id])
    @image = @album.images.find(params[:id])
    @admin = current_admin
    @comments = @image.comments
    @votes = @image.votes
    @newresponse = @image.responses.new
    @responses = Response.where(:image_id => @image)

    respond_to do |format|
      format.html 
      format.js {render :layout => false }
      format.json
    end
  end
  
  def show
    @album = Album.find(params[:album_id])
    @image = @album.images.find(params[:id])
    
    @comment = @image.comments.new
    if user_signed_in?
      @user = current_user
      @tags = @image.tags.where(:user_id => @user)
      @comments = @image.comments.where(:user_id => @user)
    else
      @user = User.find_by_ip(request.remote_ip)
      flash[:notice] = "Must be signed in to see your tags."
      @tags = @image.tags
    end
    @votes = @image.votes
    @vote = @image.votes.find_by_user_id(@user)
    @newvote = @image.votes.new
    
    @tag = @image.tags.find_by_user_id(@user)
    @newtag = @image.tags.new
    @responses = @image.responses
    
    respond_to do |format|
        format.html 
        format.json {render :layout => false}
        format.js { render :layout => false} # { render :json => @tags.map(&:attributes) }
    end
  end
end
