class List < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30}

  belongs_to :user
  has_many :items
end
