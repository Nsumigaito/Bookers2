class RelationshipsController < ApplicationController

	def create
	    following = current_user.follow(set_user)
	    if following.save
	      flash[:success] = 'ユーザーをフォローしました'
	      redirect_to request.referrer
	    else
	      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
	      redirect_to request.referrer
	    end
  	end

  	def destroy
	    following = current_user.unfollow(set_user)
	    if following.destroy
	      flash[:success] = 'ユーザーのフォローを解除しました'
	      redirect_to request.referrer
	    else
	      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
	      redirect_to request.referrer
	    end
  	end

  	private
  	def set_user
    	@user = User.find(params[:relationship], params[:follow_id])
  	end

end
