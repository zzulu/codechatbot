class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :trackable, :validatable

  has_many :bots

  after_update :set_connection_code, if: Proc.new { |user| user.user_key.nil? }

  def bots_with_templates
    Bot.templates.where.not(id: self.bots.map(&:parent_id).uniq) + bots
  end

  def set_connection_code
    self.update_columns(connection_code: SecureRandom.uuid.split('-')[1..3].sample.to_s)
  end

  def self.create_connection(user_key, connection_code)
    if user = find_by(connection_code: connection_code)
      user.update_attributes(user_key: user_key)
      true
    else
      false
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
