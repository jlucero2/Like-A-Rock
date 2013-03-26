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
    @images = Image.all
  end

    # GET /images/1
    # GET /images/1.json
  def show
    @album = Album.find(params[:album_id])
    @image = @album.images.find(params[:id])
    
    @comment = Comment.new
    if user_signed_in?
      @user = current_user
    else
      @user = User.find_by_ip(request.remote_ip)
    end
    @votes = @image.votes
    @comments = Comment.where(:user_id => @user, :image_id => @image)
    @vote = @image.votes.find_by_user_id_and_image_id(@user, @image)
    @newvote = @image.votes.new
    #@vote = @image.votes.find_by_user_id_and_image_id(@user, @image)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
      #format.js {render :layout => false }
    end
  end

    # GET /images/1/edit
  def edit
    @album = Album.find(params[:album_id])
    @image = @album.images.find(params[:id])
  end

    # PUT /images/1
    # PUT /images/1.json
  def update
    @album = Album.find(params[:album_id])
    @image = @album.images.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

    # DELETE /images/1
    # DELETE /images/1.json
  def destroy
    @album = Album.find(params[:album_id])
    @image = @album.images.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to album_images_url }
      format.json { head :no_content }
    end
  end
end
