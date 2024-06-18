class Post < ApplicationRecord
  
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :genre
  
  has_one_attached :image
  
  validates :genre_id, presence: true
  validates :title, presence: true
  validates :body, presence: true
  validates :ingredient, presence: true
  validates :method, presence: true
  validates :level, presence: true
  validates :originality, presence: true
  validates :image, presence: true
  
  
  enum level: { beginner: 0, intermediate: 1, advanced: 2 }
  enum originality: { Local_cuisine: 0, original: 1, }
  
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      image.attach(io: File.open(file_path), filename: 'no-image.jpg', content_type:'image/jpg')
    end
      image.variant(resize_to_limit: [300, 300]).processed
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
    
  
  scope :latest, -> {order(created_at: :desc) }
  scope :oldest, -> {order(created_at: :asc) }
  scope :most_favorite, -> {
    select("posts.*, COUNT(favorites.id) AS favorites_count")
    .left_joins(:favorites)
    .group("posts.id")
    .order(favorites_count: :desc)
  }
  
  
  
end
