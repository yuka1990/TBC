class Chat < ApplicationRecord
  
  belongs_to :user
  belongs_to :group
  
  validates :message, presence: true, length: { maximum: 140 }
  
  scope :search_by_message, -> (search) { where('message LIKE ?', "%#{search}%") }
  
end
