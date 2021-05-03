class Api::LikesController < ActionController::API
  before_action :authenticate_user!, only: %i[create destroy]
  def index
    render json: Like.filter_by_blog(params[:blog_id]).select(:id, :user_id, :blog_id)
  end

  def create
    @like = current_user.likes.create!(blog_id: params[:blog_id])

    if @like.save
      render json: @like, status: :created
    else
      render json: @like.errors, status: unprocessable_entity
    end
  end

  def destroy
    @like = current_user.likes.find_by(id: params[:id])
    @like.destroy!
    render json: { status: 'SUCCESS', message: 'いいねを取り消しました', data: @like }
  end
end
