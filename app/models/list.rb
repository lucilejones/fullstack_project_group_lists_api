class List < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30}

  belongs_to :user
  belongs_to :group, optional: true
  has_many :items
end
