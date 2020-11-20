class FollowsController < ApplicationController
  def update
    @user = User.find(params[:user_id])
    @following = User.find(params[:following_id])
    @follow = Follow.where(user_id: @user.id, following_id: @following.id)

    unless @user === @following || @follow.exists?
      Follow.create!(user_id: @user.id, following_id: @following.id)
    end
  end

  def destroy
    @follow = Follow.find(params[:id])
    @follow.destroy
  end
end
