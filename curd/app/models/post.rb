class Post < ApplicationRecord
  def search
    if search
      Post.where(['content LIKE ?', "%#{search}"])
    else
      Post.all
    end
end
