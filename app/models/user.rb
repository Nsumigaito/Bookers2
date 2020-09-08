class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user_id

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: {in: 2..20}
  validates :introduction, length: {maximum: 50}

  attachment :profile_image

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def self.search(search,word)

    if search == "perfect_match"
      @users = User.where("name LIKE?", "#{word}")
    elsif search == "before_match"
      @users = User.where("name LIKE?", "#{word}%")
    elsif search == "after_match"
      @users = User.where("name LIKE?", "%#{word}")
    elsif search == "parts_match"
      @users = User.where("name LIKE?", "%#{word}%")
    else
      @users = User.all
    end

  end

end
