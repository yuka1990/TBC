class HomeCountry < ApplicationRecord
  
  has_many :users, dependent: :destroy
  has_one_attached :image
  
  validates :name, presence: true, uniqueness: true
  
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      image.attach(io: File.open(file_path), filename: 'no-image.jpg', content_type:'image/jpg')
    end
      image.variant(resize_to_limit: [100, 100]).processed
  end
  
end
