class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: %i[following followers]
  before_action :not_admin, only: %i[index destroy]

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to root_path
    else
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

  def game
    @user = current_user.as_json
    avatar = current_user.avatar
    if avatar.present?
      @user['avatar'] = encode_base64(avatar)
    else
      @user['avatar'] = nil
    end
    render json: @user
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

  def encode_base64(image_file)
    avatar = Base64.encode64(image_file.download) # 画像ファイルをActive Storageでダウンロードし、エンコードする
    blob = ActiveStorage::Blob.find(image_file[:id]) # Blobを作成
    "data:#{blob[:content_type]};base64,#{avatar}" # Vue側でそのまま画像として読み込み出来るBase64文字列にして返す
  end

end
