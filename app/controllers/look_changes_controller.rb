class LookChangesController < ApplicationController
  # GET /look_changes
  # GET /look_changes.json
  def index
    @look_changes = LookChange.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @look_changes }
    end
  end

  # GET /look_changes/1
  # GET /look_changes/1.json
  def show
    @look_change = LookChange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @look_change }
    end
  end

  # GET /look_changes/new
  # GET /look_changes/new.json
  def new
    @look_change = LookChange.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @look_change }
    end
  end

  # GET /look_changes/1/edit
  def edit
    @look_change = LookChange.find(params[:id])
  end

  # POST /look_changes
  # POST /look_changes.json
  def create
    @look_change = LookChange.new(params[:look_change])

    respond_to do |format|
      if @look_change.save
        format.html { redirect_to @look_change, notice: 'Look change was successfully created.' }
        format.json { render json: @look_change, status: :created, location: @look_change }
      else
        format.html { render action: "new" }
        format.json { render json: @look_change.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /look_changes/1
  # PUT /look_changes/1.json
  def update
    @look_change = LookChange.find(params[:id])

    respond_to do |format|
      if @look_change.update_attributes(params[:look_change])
        format.html { redirect_to @look_change, notice: 'Look change was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @look_change.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /look_changes/1
  # DELETE /look_changes/1.json
  def destroy
    @look_change = LookChange.find(params[:id])
    @look_change.destroy

    respond_to do |format|
      format.html { redirect_to look_changes_url }
      format.json { head :no_content }
    end
  end
end
