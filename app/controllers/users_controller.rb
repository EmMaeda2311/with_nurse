class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only:[:following,:followers]
  # before_action :user_admin, only: [:index]

  
  def show
    @user = User.find_by(id: params[:id])
    if @user == nil
      redirect_to root_path
    else
      # @user = User.find_by(username: params[:username])
      @blogs = @user.blogs.paginate(page: params[:page])
    end
  end
  
  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  
  def index
    @users = User.all
  end

  private
  
  # def user_admin
  #   if current_user.admin == false
  #     redirect_to root_path
  #   else
  #     render action: "index"
  #   end
  # end
end
