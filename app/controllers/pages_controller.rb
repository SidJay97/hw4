class PagesController < ApplicationController
  def home
    redirect_to places_path if session[:user_id]
  end
end
