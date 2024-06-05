class Post < ApplicationRecord
  
  has_many :comments, dependent: :destroy
  has_many :favoreites, dependent: :destroy
  belongs_to :user
  belongs_to :genre
  
end
