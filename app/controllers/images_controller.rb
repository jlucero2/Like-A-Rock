class ImagesController < ApplicationController
  # GET /images/new
    # GET /images/new.json
  def new
    @album = Album.find(params[:album_id])
    @image = @album.images.new(params[:image])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end
    
  def tagTest
    #@album = Album.find(params[:album_id]) 
    #@images = Image.order('votes_count DESC').all(:limit => 100)
    #@moreImages = Image.order('votes_count DESC').all(:limit => 200)
    @id = "ID"
    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @albums }
      format.js {render :layout => false}
    end
  end 
  
  def create #UPDATED FOR ALBUMS
    @album = Album.find(params[:album_id])
    @image = @album.images.create(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to album_image_path(@album, @image), notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def index
    @album = Album.find(params[:album_id])
    redirect_to album_path(@album)
  end

    # GET /images/1
    # GET /images/1.json
    
  def adminShow
    @album = Album.find(params[:album_id])
    @image = @album.images.find(params[:id])

    @comment = Comment.new
    if user_signed_in?
      @user = current_user
    else
      @user = User.find_by_ip(request.remote_ip)
    end

    if admin_signed_in?
      @comments = Comment.where(:image_id => @image)
      @admin = current_admin
    elsif user_signed_in?
      @comments = Comment.where(:user_id => @user, :image_id => @image)
    end
    @votes = @image.votes
    @vote = @image.votes.find_by_user_id(@user)
    @newvote = @image.votes.new
    @responses = Response.where(:image_id => @image)
    @newresponse = Response.new

      #@tag = @image.tags.find_by_user_id_and_image_id(@user, @image)
      #@newtag = @image.tags.new
    if user_signed_in? 
        @tags = @image.tags.where(:user_id => @user)
    else
      flash[:notice] = "Must be signed in to see your tags."
    end

    respond_to do |format|
        format.html 
        format.json {render :layout => false}
        format.js {render :layout => false }
    end
  end
  
  def show
    @album = Album.find(params[:album_id])
    @image = @album.images.find(params[:id])
    
    @comment = Comment.new
    if user_signed_in?
      @user = current_user
    else
      @user = User.find_by_ip(request.remote_ip)
    end
    
    if admin_signed_in?
      @comments = Comment.where(:image_id => @image)
      @admin = current_admin
    else
      @comments = Comment.where(:user_id => @user, :image_id => @image)
    end
    @votes = @image.votes
    @vote = @image.votes.find_by_user_id_and_image_id(@user, @image)
    @newvote = @image.votes.new
    @responses = Response.where(:image_id => @image)
    @newresponse = Response.new
    
    
    @tag = @image.tags.find_by_user_id_and_image_id(@user, @image)
    #@newtag = @image.tags.new
    if user_signed_in? 
        @tags = @image.tags.where(:user_id => @user)
    else
      flash[:notice] = "Must be signed in to see your tags."
      @tags = @image.tags
    end
    
    respond_to do |format|
        format.html 
        format.json {render :layout => false}
        format.js { render :json => @tags.map(&:attributes) }
    end
  end
end
