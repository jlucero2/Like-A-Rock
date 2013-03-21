class ImagesController < ApplicationController
  
  # GET /images/new
    # GET /images/new.json
    def new
      @album = Album.find(params[:album_id])
      @image = @album.images.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @image }
      end
    end
    
    
  def create #UPDATED FOR ALBUMS
    @album = Album.find(params[:album_id])
    @image = @album.images.create(params[:image])
    #@image.sol = @album.sol
    #@image.album = @album
    #@image.score = 0

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
  
  
   # GET /images
    # GET /images.json
    def index
      @album = Album.find(params[:album_id])
      redirect_to album_path(@album)
    end

    # GET /images/1
    # GET /images/1.json
<<<<<<< HEAD
  def show
    @album = Album.find(params[:album_id])
    @image = @album.images.find(params[:id])
    @vote = Vote.new
    @comment = Comment.new
    @comments = Comment.where(:user_id => current_user, :image_id => @image)
    if current_user
      @data = current_user.id.to_s
    else
      @data = request.remote_ip.to_s
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
=======
    def show
      @album = Album.find(params[:album_id])
      @image = @album.images.find(params[:id])
      @vote = Vote.new
      @comment = Comment.new
      @comments = Comment.where(:user_id => current_user, :image_id => @image)
      if current_user
        @data = current_user.id.to_s
      else
        @data = request.remote_ip.to_s
      end
  

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @image }
      end
>>>>>>> 6d8ae5b... I think this is the actual admin login. The last commit had minor changes
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
