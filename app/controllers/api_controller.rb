class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :validate_message_type, only:[:message]
  before_action :validate_connection, only:[:message]

  def message
    bot = @user.bots.find_by(message: @content)
    if bot.present?
      result = bot.run_code
    else
      bot = Bot.templates.find_by(message: @content)
      if bot.present?
        result = bot.run_code
      end
    end
    
    if bot.present?
      result = "# #{@user.username} 봇\r\n#{result}"
    else
      result = "# #{@user.username} 봇\r\n설정되지 않은 입력 메시지 입니다. (#{@content})"

    end
    @user.send_message(result)
    # render json: {'message': {'text': result}}
    render json: {}, status: :ok
  end

  # def create_friend
  #   @user = User.find_by(user_key: params[:user_key])
  #   if @user.present?
  #     @user.update_attributes(friend: true, in_chat_room: true)
  #   end
  #   render json: {}, status: :ok
  # end

  # def destroy_friend
  #   @user = User.find_by(user_key: params[:user_key])
  #   if @user.present?
  #     @user.update_attributes(friend: false)
  #   end
  #   render json: {}, status: :ok
  # end

  # # exit chatroom
  # def chat_room
  #   @user = User.find_by(user_key: params[:user_key])
  #   if @user.present?
  #     @user.update_attributes(in_chat_room: false)
  #   end
  #   render json: {}, status: :ok
  # end

  # def keyboard
  #   render json: {'type': 'text'}
  # end

  private

    def validate_connection
      @user = User.find_by(user_key: params[:message][:from][:id])  
      if @user.nil? 
        if @user = User.create_connection(params[:message][:from][:id], @content)
          @user.send_message("반갑습니다, #{@user.username}님 :) 계정 연동에 성공하였습니다. \'인증 완료\' 버튼을 클릭하여 나만의 챗봇 만들기를 시작해 보세요!")
          # render json: {'message': {'text': "반갑습니다, #{@user.username}님 :) 계정 연동에 성공하였습니다. \'인증 완료\' 버튼을 클릭하여 나만의 챗봇 만들기를 시작해 보세요!"}}
          # 타인의 계정과 연동 되었을 경우, 처리 방법 고안해야함.
          render json: {}, status: :ok
        elsif @content.length == 4 && @content.match(/[a-z0-9]{4}/i).present?
          User.send_message(params[:message][:from][:id], '인증 코드가 만료 되었거나, 잘못된 인증 코드를 입력하셨습니다.')
          # render json: {'message': {'text': '인증 코드가 만료 되었거나, 잘못된 인증 코드를 입력하셨습니다.'}}
          render json: {}, status: :ok
        else
          User.send_message(params[:message][:from][:id], "계정 연동이 되어있지 않습니다. https://#{ENV.fetch("CHATBOT_LANGUAGE_EXTENSION") { 'rb' }}.hphk.io 에서 계정 생성 후, 계정 연동을 진행해 주시기 바랍니다.")
          # render json: {'message': {'text': "계정 연동이 되어있지 않습니다. https://#{ENV.fetch("CHATBOT_LANGUAGE_EXTENSION") { 'rb' }}.hphk.io 에서 계정 생성 후, 계정 연동을 진행해 주시기 바랍니다."}}
          render json: {}, status: :ok
        end
      elsif @user.connection_code.present?
        if @user.authentication_for_reset_password(params[:message][:from][:id], @content)
          User.send_message(params[:message][:from][:id], "계정이 인증되었습니다. \'인증 완료\' 버튼을 클릭하여 비밀번호 재설정을 진행해 주시기 바랍니다.")
          # render json: {'message': {'text': "계정이 인증되었습니다. \'인증 완료\' 버튼을 클릭하여 비밀번호 재설정을 진행해 주시기 바랍니다."}}
          render json: {}, status: :ok
        end
      end
    end

    def validate_message_type
      if params[:message].has_key?(:text)
        @content = params[:message][:text]
      else
        #TODO: API sendMessage
        User.send_message(params[:message][:from][:id], '텍스트만 입력 가능합니다.')
        # render json: {'message': {'text': '텍스트만 입력 가능합니다.'}}
        render json: {}, status: :ok
      end
    end
end
