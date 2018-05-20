class Bot < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: "Bot"
  has_many :children, class_name: "Bot", foreign_key: "parent_id"
 end
