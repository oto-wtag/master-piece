class ArtworksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_artwork, only: [ :show, :edit, :update, :destroy, :like ]
  before_action :authorize_artwork!

  def index
    @artworks = Artwork.includes(image_attachment: :blob, likes: :user).all.order(created_at: :desc)
    @artwork = Artwork.new
  end

  def show
  end

  def create
    @artwork = Artwork.new(artwork_params.merge(user_id: current_user.id))
    if @artwork.save
      redirect_to artworks_path, notice: "Artwork was successfully created."
    else
      @artworks = Artwork.includes(image_attachment: :blob,  likes: :user).all.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @artwork.update(artwork_params)
      redirect_to artworks_path, notice: "Artwork was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @artwork.destroy
      redirect_to artworks_path, notice: "Artwork was successfully deleted."
    else
      redirect_to artworks_path, alert: "Failed to delete artwork."
    end
  end

  def like
    if current_user.liked_artworks.include?(@artwork)
      current_user.liked_artworks.delete(@artwork)
    else
      current_user.liked_artworks << @artwork
    end
    redirect_to request.referer || artworks_path
  end

  private

  def authorize_artwork!
    authorize! :manage, @artwork
  end

  def set_artwork
    @artwork = Artwork.find(params[:id])
  end

  def artwork_params
    params.require(:artwork).permit(:title, :description, :image)
  end
end
