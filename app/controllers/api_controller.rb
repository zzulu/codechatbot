class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :validate_message_type, only:[:message]
  before_action :validate_connection, only:[:message]

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

  # exit chatroom
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

    def validate_connection
      @user = User.find_by(user_key: params[:user_key])  
      if @user.nil? 
        if @user = User.create_connection(params[:user_key], @content)
          render json: {'message': {'text': "반갑습니다, #{@user.username}님. 계정 연동에 성공하였습니다. \'인증 완료\' 버튼을 클릭하여 나만의 챗봇 만들기를 시작해 보세요 :)"}}
          # 타인의 계정과 연동 되었을 경우, 처리 방법 고안해야함.
        elsif @content.length == 4 && @content.match(/[a-z0-9]{4}/i).present?
          render json: {'message': {'text': '인증 코드가 만료 되었거나, 잘못된 인증 코드를 입력하셨습니다.'}}
        else
          render json: {'message': {'text': '계정 연동이 되어있지 않습니다. rb.chatbot.io에서 계정 생성 후, 계정 연동을 진행해 주시기 바랍니다.'}}
        end
      end
    end

    def validate_message_type
      if params[:type] = 'text'
        @content = params[:content]
      else
        render json: {'message': {'text': '텍스트만 입력 가능합니다.'}}
      end
    end
end
