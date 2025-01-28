class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :follow ]
  before_action :authenticate_user!

  def show
    @artist_detail = @user.artist_detail
    @artworks = @user.artworks
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def follow
    if current_user == @user
      flash[:alert] = "You cannot follow yourself."
      redirect_to request.referer || @user and return
    end

    if current_user.followed_users.include?(@user)
      flash[:alert] = "You are already following this user."
      redirect_to request.referer || @user and return
    end

    current_user.followed_users << @user

    flash[:notice] = "You are now following #{@user.name}."
    redirect_to request.referer || @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render file: Rails.root.join("public", "404.html"), status: :not_found, layout: false
  end

  def user_params
    params.require(:user).permit(:name, :email, :profile_photo, :phone_number, :bio, :is_active)
  end
end
