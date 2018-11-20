class Comment < ApplicationRecord
  belongs_to :company

  validates :name, presence: true
  validates :body, presence: true
end
