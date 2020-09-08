class Book < ApplicationRecord

  	has_many :favorites, dependent: :destroy
  	has_many :book_comments, dependent: :destroy

	belongs_to :user

	validates :title, presence: true

	validates :body, presence: true, length: {maximum: 200}

	def favorited_by?(user)

	    favorites.where(user_id: user.id).exists?

  	end

  	def self.search(search,word)

  		if search == "perfect_match"
	      	@books = Book.where("title LIKE?", "#{word}")
	    elsif search == "before_match"
	      	@books = Book.where("title LIKE?", "#{word}%")
	    elsif search == "after_match"
	     	@books = Book.where("title LIKE?", "%#{word}")
	    elsif search == "parts_match"
	      	@books = Book.where("title LIKE?", "%#{word}%")
	    else
	      	@books = Book.all
	    end

  	end

end
