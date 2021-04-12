class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: %i[following followers]
  before_action :not_admin, only: %i[index destroy]

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to root_path
    else
      # @user = User.find_by(username: params[:username])
      @blogs = @user.blogs.paginate(page: params[:page])
    end
  end

  def following
    @title = 'フォロー'
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'フォロワー'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def index
    @users = User.all
  end

  def destroy
    @admin_user_id = current_user.id
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path(current_user.id)
  end

  private
  def not_admin
    redirect_to root_path unless current_user.admin?
  end

end
