class Bot < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :parent, class_name: "Bot", optional: true
  has_many :children, class_name: "Bot", foreign_key: "parent_id"

  scope :templates, -> { where(user_id: nil) }
 end
