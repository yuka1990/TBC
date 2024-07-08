class Permit < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_one :notifications, as: :notifiable, dependent: :destroy 
end
