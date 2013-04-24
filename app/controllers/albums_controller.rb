class AlbumsController < ApplicationController
  def index
    @albums = Album.order('earthday DESC').where('earthday IS NOT NULL')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
      format.js {render :layout => false}
    end
  end
  
  def solAlbums
    @albums = Album.order('cast(sol AS INT) DESC').where('earthday IS NULL')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
      format.js {render :layout => false}
    end
  end

  def recentResponses
    #@albums = Album.all
    @latestResponses = Response.order('created_at DESC').all(:limit => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
      format.js {render :layout => false}
    end
  end

  def popular
    #@albums = Album.all
    @images = Image.order('votes_count DESC').all(:limit => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
      format.js {render :layout => false}
    end
  end
  
  def show
    @album = Album.find(params[:id])
    @images = @album.images
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album, json: @images }
      format.js {render :layout => false}
    end
  end
  
  def commentsAlbum
    @images = Image.where(:responses_count => 0).order('comments_count DESC').limit(10)
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
      format.js {render :layout => false}
    end
  end
  
  def trendingAlbum
    @votes = Vote.order('created_at DESC').all(:limit => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
      format.js {render :layout => false}
    end
  end
  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(params[:album])

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.json
  def update
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
  end
end

