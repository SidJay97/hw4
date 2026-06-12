class PlacesController < ApplicationController
  before_action :require_login

  def index
    @places = current_user.places
  end

  def show
    @place = Place.find(params[:id])
    authorize_user!
  end

  def new
    @place = Place.new
  end

  def create
    @place = current_user.places.build(place_params)
    if @place.save
      redirect_to places_path
    else
      render :new
    end
  end

  private

  def place_params
    params.require(:place).permit(:name)
  end

  def require_login
    redirect_to login_path unless current_user
  end

  def authorize_user!
    redirect_to places_path unless @place.user_id == current_user.id
  end
end
