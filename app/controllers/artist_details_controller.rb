class ArtistDetailsController < ApplicationController
  before_action :set_artist_detail, only: %i[edit update]
  before_action :authenticate_user!

  def new
    authorize! :create, ArtistDetail
    @artist_detail = ArtistDetail.new
  end

  def create
    authorize! :create, ArtistDetail
    @artist_detail = ArtistDetail.new(artist_detail_params)
    @artist_detail.user = current_user

    if @artist_detail.save
      redirect_to user_path(current_user), notice: "Artist detail was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :create, ArtistDetail
    authorize! :update, @artist_detail
  end

  def update
    authorize! :create, ArtistDetail
    authorize! :update, @artist_detail
    if @artist_detail.update(artist_detail_params)
      redirect_to user_path(current_user), notice: "Artist detail was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_artist_detail
    @artist_detail = ArtistDetail.find(params[:id])
  end

  def artist_detail_params
    params.require(:artist_detail).permit(:instagram_link, :pinterest_link, :dribble_link, :behance_link, :etsy_link)
  end
end
