# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  skip_before_action :authenticate_user_from_token!, only: [:create], :raise => false

  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  # end
  def create
    user = User.find_by(email: create_params[:email])
    user&.send_reset_password_instructions
    render json: {}
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  private

  def create_params
    params.require(:user).permit(:email)
  end
  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
