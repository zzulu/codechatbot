class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :validate_message, only:[:message]
  before_action :validate_connected, only:[:message]

  def message
    render json: {'message': {'text': @content}}
  end

  def create_friend
    @user = User.find_by(user_key: params[:user_key])
    if @user.present?
      @user.update_attributes(friend: true, in_chat_room: true)
    end
    render json: {}, status: :ok
  end

  def destroy_friend
    @user = User.find_by(user_key: params[:user_key])
    if @user.present?
      @user.update_attributes(friend: false)
    end
    render json: {}, status: :ok
  end

  def chat_room
    @user = User.find_by(user_key: params[:user_key])
    if @user.present?
      @user.update_attributes(in_chat_room: false)
    end
    render json: {}, status: :ok
  end

  def keyboard
    render json: {'type': 'text'}
  end

  private

    def validate_connected
      @user = User.find_by(user_key: params[:user_key])  
      if @user.nil?
        @user = User.find_by(auth_code: @content)
        if @user.present?
          @user.update_attributes(user_key: params[:user_key])
        else
          render json: {'message': {'text': '계정 연동이 되어있지 않습니다. rb.chatbot.io에서 계정 생성 후, 계정 연동을 진행해 주시기 바랍니다.'}}
        end
      end
    end

    def validate_message
      if params[:type] = 'text'
        @content = params[:content]
      else
        render json: {'message': {'text': '텍스트만 입력 가능합니다.'}}
      end
    end
end
