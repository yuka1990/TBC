class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users, dependent: :destroy
  belongs_to :home_country
  has_many :chats, dependent: :destroy
  has_many :permits, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  validates :name, presence: true
  validates :nickname, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, length: { minimum: 6 }, on: :create


  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL ) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.name = "guestuser"
      user.home_country_id = "1"
      user.nickname = "guestuser"
    end
  end
  
  before_update :delete_associated_records, if: -> { is_active_changed? && !is_active }
  
  def delete_associated_records
      posts.destroy_all
      comments.destroy_all
      favorites.destroy_all
      groups.destroy_all
      group_users.destroy_all
      Group.where(owner_id: id).destroy_all
      chats.destroy_all
  end
  
end
