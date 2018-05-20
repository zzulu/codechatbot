class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :trackable, :validatable

  has_many :bots

  def bots_with_templates
    Bot.templates.where.not(id: self.bots.map(&:parent_id).uniq) + bots
  end

  # For username sign in
  def email_required?
    false
  end 

  def will_save_change_to_email?
    false
  end
end
