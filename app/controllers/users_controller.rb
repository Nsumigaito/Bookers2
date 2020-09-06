class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update]

  def following
    @title = "Follow Users"
    @follows_table = 0
    @user = User.find(params[:id])
    if @user.relationships.count == 0
      @text = "ユーザーはいません"
      @follows_table = 1
    end
    @users = @user.followings.all
    render 'show_follow'
  end

  def followers
    @title = "Follower Users"
    @followers_table = 0
    @user = User.find(params[:id])
    if @user.reverse_of_relationships.count == 0
      @text = "ユーザーはいません"
      @followers_table = 1
    end
    @users = @user.reverse_of_relationships.all
    render 'show_follow'
  end

  def index
  	@users = User.all
    @user = User.find(current_user.id)
    @book_new = Book.new
  end

  def show
  	@user = User.find(params[:id])
    @book_new = Book.new
  	@books = @user.books.all
  end

  def edit
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully.'
	    redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
    def user_params
    	params.require(:user).permit(:name, :introduction, :profile_image)
    end

end
