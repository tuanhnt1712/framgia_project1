class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: {maximum: Settings.post.maximun_title}
  validates :content, presence: true, length: {maximum: Settings.post.maximum_content}
end
