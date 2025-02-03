class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :follow ]
  before_action :authenticate_user!

  def show
    authorize! :read, User

    @artist_detail = @user.artist_detail
    @artworks = @user.artworks
  end

  def edit
    authorize! :update, @user
  end

  def update
    authorize! :update, @user

    if @user.update(user_params)
      redirect_to @user, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def follow
    authorize! :follow, @user

    if current_user == @user
      flash[:alert] = "You cannot follow yourself."
      redirect_to request.referer || @user and return
    end

    if current_user.followed_users.include?(@user)
      current_user.followed_users.delete(@user)
      flash[:notice] = "You have unfollowed #{@user.name}."
      redirect_to request.referer || @user and return
    end

    current_user.followed_users << @user

    flash[:notice] = "You are now following #{@user.name}."
    redirect_to request.referer || @user
  end

  def destroy
    authorize! :destroy, @user

    if current_user == @user
      current_user.destroy
      flash[:notice] = "Your account has been successfully deleted."
      redirect_to root_path
    else
      flash[:alert] = "You can only delete your own account."
      redirect_to @user
    end
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
