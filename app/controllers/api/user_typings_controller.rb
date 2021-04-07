class Api::UserTypingsController < ApplicationController
  before_action :find_user_score, only: [:show, :update]

  def create
    @user_typing_score = current_user.create_user_typing( typing_score_params )
    if @user_typing_score.save
      render json: @user_typing_score, status: :created
    else
      render json: { errors: @user_typing_score.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user_typing_score.update( typing_score_params )
      render json: @user_typing_score
    else
      render json: { errors: @user_typing_score.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @user_typing_score 
  end

  private

  def typing_score_params
    params.require(:user_typing).permit(:hi_score, :hi_speed, :plays, :updated_at)
  end

  def find_user_score
    if current_user.reload_user_typing == nil
      @user_typing_score = {hi_score: 0, hi_speed: 0, plays: 0}
    else
      @user_typing_score = current_user.reload_user_typing
    end
  end

  

end
