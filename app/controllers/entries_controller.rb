class EntriesController < ApplicationController
  before_action :require_login

  def new
    @place = Place.find(params[:place_id])
    authorize_place_user!
    @entry = Entry.new
  end

  def create
    @place = Place.find(params[:place_id])
    authorize_place_user!
    @entry = @place.entries.build(entry_params)
    @entry.user_id = current_user.id
    if @entry.save
      redirect_to place_path(@place)
    else
      render :new
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :image)
  end

  def require_login
    redirect_to login_path unless current_user
  end

  def authorize_place_user!
    redirect_to places_path unless @place.user_id == current_user.id
  end
end
