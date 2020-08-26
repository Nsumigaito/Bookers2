class BooksController < ApplicationController
  	before_action :authenticate_user!, only: [:index, :show, :edit, :update]

	def create
		@user = User.find(current_user.id)
		@book_new = Book.new(book_params)
		@book_new.user_id = current_user.id
		if @book_new.save
      		flash[:notice] = 'You have creatad book successfully.'
			redirect_to book_path(@book_new.id)
		else
			@books = Book.all
			render :index
		end
	end

	def index
		@book_new = Book.new
		@books = Book.all
		@user = User.find(current_user.id)
	end

	def show
		@book_new = Book.new
		@book = Book.find(params[:id])
		@user = User.find(current_user.id)
	end

	def edit
		@book = Book.find(params[:id])
		# correct_user(@book)
		if current_user.id != @book.user_id
			redirect_to books_path
		end
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
      		flash[:notice] = 'You have updated book successfully.'
			redirect_to book_path(@book.id)
		else
			render :edit
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :body, :user)
	end

  	def correct_user(book)
    	if current_user.id != book.user_id
      	redirect_to books_path
   	end
  end
end
