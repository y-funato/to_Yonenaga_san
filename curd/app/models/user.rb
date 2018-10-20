class User < ApplicationRecord
  belongs_to :group
  has_many :name_cards

  validates :name, presence: true, length: { maximum: 100 }
  validates :tel, format: {with: /\A[0-9]{2,4}-[0-9]{2,4}-[0-9]{4}\Z/}
  validates :mail, length: { maximum: 100, minimun: 3 }, allow_blank: true, uniqueness: true, format: { with: /\A[A-Z0-9\.\_\-_+]+@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
end
