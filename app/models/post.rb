class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: {maximum: Settings.post.maximun_title}
  validates :content, presence: true

  scope :sort_by_created_at, ->{order created_at: :desc}
  scope :feed_load, lambda{|x,y|
    where("user_id IN (?) OR user_id = ?", x, y)}
end
