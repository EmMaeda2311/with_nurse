class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]	
  # before_action :correct_user, only:[:edit,:update,:show]
  

  def show
    @user = User.find_by(id: params[:id])
    # @user = User.find_by(username: params[:username])
    @blogs = @user.blogs.paginate(page: params[:page])
  end
  
  private
  
  def correct_user
    @user = User.find_by(id: params[:id])
    if @user == nil || @user != current_user
      redirect_to(root_url)
    end
  end
end
