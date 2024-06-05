class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :comments, dependent: :destroy
  has_many :favoreites, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  belongs_to :home_country



end
