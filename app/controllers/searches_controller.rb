class SearchesController < ApplicationController

	def search

		@range = params[:range]
		search = params[:search]
		@word = params[:word]

		if @range == '1'
			@users = User.search(search,@word)
			@title = "Users"
		else
			@books = Book.search(search,@word)
			@title = "Books"
		end

	end

end

