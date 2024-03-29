class Group < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30}

  # belongs_to :user
  belongs_to :creator, class_name: "User", foreign_key: "user_id"

  has_many :group_users
  # has_many :users, through: :group_users
  has_many :members, through: :group_users, source: :user
end
