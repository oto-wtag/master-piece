class ArtworksController < ApplicationController
  def index
    @artworks = Artwork.includes(image_attachment: :blob).all.order(created_at: :desc)
    @artwork = Artwork.new
  end

  def show
    @artwork = Artwork.find(params[:id])
  end

  def new
    @artwork = Artwork.new
  end

  def create
    @artwork = Artwork.new(artwork_params.merge(user_id: current_user.id))
    if @artwork.save
      redirect_to artworks_path, notice: "Artwork was successfully created."
    else
      @artworks = Artwork.includes(image_attachment: :blob).all.order(created_at: :desc)
      render :index
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def artwork_params
    params.require(:artwork).permit(:title, :description, :image)
  end
end
