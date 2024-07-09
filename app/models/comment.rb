class Comment < ApplicationRecord

 belongs_to :user
 belongs_to :post
 has_one :notification, as: :notifiable, dependent: :destroy 

 validates :body, presence: true
 
 
 
 scope :search_by_body, -> (search) { where('body LIKE ?', "%#{search}%") }
 scope :search_by_min_score, -> (min_score) { where('score >= ?', min_score) }
 scope :search_by_max_score, -> (max_score) { where('score <= ?', max_score) }
 
 
 after_create do
  create_notification(user_id: post.user_id)
 end

end
