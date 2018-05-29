class Bot < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :parent, class_name: "Bot", optional: true
  has_many :children, class_name: "Bot", foreign_key: "parent_id"

  scope :templates, -> { where(user_id: nil) }

  validates :message, presence: {message: '입력 메시지를 입력하세요.'}, uniqueness: {message: '존재하는 입력 메세지입니다. 다른 메시지를 입력해 주세요.'}
 end
