class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_artwork
  before_action :set_comment, only: [ :edit, :update, :destroy ]

  def create
    authorize! :create, Comment

    @comment = @artwork.comments.new(comment_params.merge(user_id: current_user.id))
    if @comment.save
      redirect_to request.referer, notice: "Comment added successfully."
    else
      redirect_to request.referer || artworks_path, alert: "Failed to add comment: #{@comment.errors.full_messages.to_sentence}"
    end
  end

  def edit
  end

  def update
    authorize! :update, Comment

    if @comment.update(comment_params)
      redirect_to artwork_path(@artwork), notice: "Comment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    authorize! :destroy, Comment

    if @comment.destroy
      redirect_to request.referer || artworks_path, notice: "Comment was successfully deleted."
    else
      redirect_to request.referer || artworks_path, alert: "Failed to delete comment."
    end
  end

  private

  def set_artwork
    @artwork = Artwork.find(params[:artwork_id])
  end

  def set_comment
    @comment = @artwork.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
