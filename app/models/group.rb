class Group < ApplicationRecord

  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :permits, dependent: :destroy


  validates :name, presence: true
  validates :introduction, presence: true

  def is_owned_by?(user)
    owner_id == user.id
  end

  def owner_nickname
    owner.nickname
  end

  def includesUser?(user)
    group_users.exists?(user_id: user.id)
  end

  private

  def owner
    User.find_by(id: owner_id)
  end

end
