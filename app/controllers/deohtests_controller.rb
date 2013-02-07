class DeohtestsController < ApplicationController
  # GET /deohtests
  # GET /deohtests.json
  def index
    @deohtests = Deohtest.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @deohtests }
    end
  end

  # GET /deohtests/1
  # GET /deohtests/1.json
  def show
    @deohtest = Deohtest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @deohtest }
    end
  end

  # GET /deohtests/new
  # GET /deohtests/new.json
  def new
    @deohtest = Deohtest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @deohtest }
    end
  end

  # GET /deohtests/1/edit
  def edit
    @deohtest = Deohtest.find(params[:id])
  end

  # POST /deohtests
  # POST /deohtests.json
  def create
    @deohtest = Deohtest.new(params[:deohtest])

    respond_to do |format|
      if @deohtest.save
        format.html { redirect_to @deohtest, notice: 'Deohtest was successfully created.' }
        format.json { render json: @deohtest, status: :created, location: @deohtest }
      else
        format.html { render action: "new" }
        format.json { render json: @deohtest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /deohtests/1
  # PUT /deohtests/1.json
  def update
    @deohtest = Deohtest.find(params[:id])

    respond_to do |format|
      if @deohtest.update_attributes(params[:deohtest])
        format.html { redirect_to @deohtest, notice: 'Deohtest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @deohtest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deohtests/1
  # DELETE /deohtests/1.json
  def destroy
    @deohtest = Deohtest.find(params[:id])
    @deohtest.destroy

    respond_to do |format|
      format.html { redirect_to deohtests_url }
      format.json { head :no_content }
    end
  end
end
