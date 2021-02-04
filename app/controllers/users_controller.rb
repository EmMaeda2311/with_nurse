class UsersController < ApplicationController
  before_action :authenticate_user!	
  before_action :correct_user, only:[:edit,:update,:show]
  

  def show
    @user = User.find_by(id: params[:id])
  end
  
  private
  
  def correct_user
    @user = User.find_by(id: params[:id])
    if @user == nil || @user != current_user
      redirect_to(root_url)
    end
  end
end
