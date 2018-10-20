class Group < ApplicationRecord
  belongs_to :company
  has_many :users

  validates :name, presence: true, length: {maximum: 100}
end
