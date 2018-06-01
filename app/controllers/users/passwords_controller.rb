# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    # super
    self.resource = resource_class.find_or_initialize_by(params.require(:user).permit(:username))
    if resource.new_record?
      flash[:notice] = "계정이 존재하지 않습니다."
      redirect_to new_user_password_path
    elsif resource.user_key.nil?
      flash[:notice] = "계정 연결이 되어 있지 않은 계정은 비밀번호 재설정을 진행할 수 없습니다."
      redirect_to new_user_password_path
    else
      resource.set_connection_code
      redirect_to account_authentication_path(code: resource.connection_code)
    end
  end

  # GET /resoures/account_authentication?code=1234
  def account_authentication
  end

  # POST /resoures/account_authentication

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
