class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :trackable, :validatable

  has_many :bots

  validates :username, presence: {message: '이름을 입력하세요.'}, uniqueness: {message: '존재하는 이름입니다. 다른 이름을 입력해 주세요.'}

  after_update :set_connection_code, if: Proc.new { |user| user.user_key.nil? }

  def bots_with_templates
    Bot.templates.where.not(id: self.bots.map(&:parent_id).uniq) + bots
  end

  def set_connection_code
    self.update_columns(connection_code: SecureRandom.uuid.split('-')[1..3].sample.to_s)
    # 중복된 값이 set 되는 경우, 오류 발생함. 예외 처리 필요.
  end

  def clear_connection_code
    self.update_columns(connection_code: nil)
  end

  def disconnect
    self.update_columns(user_key: nil, friend: false, in_chat_room: false)
  end

  def self.create_connection(user_key, connection_code)
    if user = find_by(connection_code: connection_code)
      user.update_attributes(user_key: user_key, connection_code: nil, friend: true, in_chat_room: true)
      user
    else
      nil
    end
  end

  # For username sign in
  def email_required?
    false
  end 

  def will_save_change_to_email?
    false
  end
end
