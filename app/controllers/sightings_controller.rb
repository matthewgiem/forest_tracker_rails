class SightingsController < ApplicationController
  has_scope: region

  def new
    @regions = Region.all
    @animal = Animal.find(params[:animal_id])
    @sighting = @animal.sightings.new
  end

  def index
    @sightings = Sighting.all
    render :index
  end

  def create
    @animal = Animal.find(params[:animal_id])
    @sighting = @animal.sightings.new(sighting_params)
    if @sighting.save
      redirect_to animal_path(@sighting.animal)
    else
      render :new
    end
  end

  def edit
    @animal = Animal.find(params[:animal_id])
    @sighting = Sighting.find(params[:id])
    render :edit
  end

  def update
    @sighting = Sighting.find(params[:id])
    if @sighting.update(sighting_params)
      redirect_to animal_path(@sighting.animal)
    else
      render :edit
    end
  end

  def destroy
    @sighting = Sighting.find(params[:id])
    @sighting.destroy
    redirect_to animal_path(@sighting.animal)
  end

  private
  def sighting_params
    params.require(:sighting).permit(:date, :lat, :long, :region_id)
  end
end
