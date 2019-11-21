class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :validatable,
         :recoverable

  has_many :bots

  validates :username, presence: {message: '이름을 입력하세요.'}, uniqueness: {message: '존재하는 이름입니다. 다른 이름을 입력해 주세요.'}

  after_update :set_connection_code, if: Proc.new { |user| user.user_key.nil? }
  after_update :clear_connection_code, if: Proc.new { |user| user.connection_code.present? && user.user_key.present?}

  def bots_with_templates
    Bot.templates.where.not(id: self.bots.map(&:parent_id).uniq) + bots
  end

  def set_connection_code
    begin
      self.update_columns(connection_code: SecureRandom.uuid.split('-')[1..3].sample.to_s)
    rescue ActiveRecord::RecordNotUnique
      retry
    end
  end

  def clear_connection_code
    self.update_columns(connection_code: nil)
  end

  def disconnect
    self.update_columns(user_key: nil, friend: false, in_chat_room: false)
  end

  def authentication_for_reset_password(user_key, connection_code)
    if self.connection_code == connection_code
      self.clear_connection_code
      Pusher.trigger("account-connection-#{connection_code}", 'authenticated', { token: self.set_reset_password_token })
      true
    else
      false
    end
  end

  def send_message(text)
    User.send_message(self.user_key, text)
  end

  def self.create_connection(user_key, connection_code)
    if user = find_by(connection_code: connection_code)
      user.update_attributes(user_key: user_key, friend: true, in_chat_room: true)
      Pusher.trigger("account-connection-#{connection_code}", 'connected', { code: connection_code })
      user
    else
      nil
    end
  end

  def self.send_message(chat_id, text)
    response = HTTParty.post("https://api.telegram.org/bot#{Rails.application.credentials.dig(:telegram_bot_token)}/sendMessage",
                                body: {
                                  chat_id: chat_id,
                                  text: text,
                                })
  end

  def admin?
    self.role == 'admin'
  end

  # For username sign in
  def email_required?
    false
  end 

  def will_save_change_to_email?
    false
  end
end
