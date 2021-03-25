class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only:[:edit,:update]
  

  def show
    @user = User.find_by(id: params[:id])
    if @user == nil
      redirect_to root_path
    else
      # @user = User.find_by(username: params[:username])
      @blogs = @user.blogs.paginate(page: params[:page])
    end
  end
  

end
