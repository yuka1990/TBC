class Post < ApplicationRecord
  
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :genre
  
  has_one_attached :image
  
  validates :genre_id, presence: true
  validates :title, presence: true, length: { maximum: 20 }
  validates :body, presence: true
  validates :ingredient, presence: true
  validates :method, presence: true
  validates :level, presence: true
  validates :originality, presence: true
  validates :image, presence: true
  
  enum level: { Beginner: 0, Intermediate: 1, Advanced: 2 }
  enum originality: { Local_cuisine: 0, Original: 1, }
  
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
    
  scope :search, -> (keyword) { where('title LIKE :keyword OR ingredient LIKE :keyword', keyword: "%#{keyword}%") }
  scope :by_genre, ->(genre_id) { where(genre_id: genre_id) }
  scope :by_level, ->(level) { where(level: level) }
  scope :by_originality, ->(originality) { where(originality: originality) }
  scope :by_home_country, ->(country_id) { joins(user: :home_country).where('home_countries.id = ?', country_id) }
  scope :latest, -> {order(created_at: :desc) }
  scope :oldest, -> {order(created_at: :asc) }
  scope :most_favorite, -> {
    select("posts.*, COUNT(favorites.id) AS favorites_count")
    .left_joins(:favorites)
    .group("posts.id")
    .order(favorites_count: :desc)
  }
  
end
