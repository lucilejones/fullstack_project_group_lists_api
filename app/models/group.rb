class Group < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30}

  belongs_to :user

  has_many :group_users
  has_many :users, through: :group_users
end
