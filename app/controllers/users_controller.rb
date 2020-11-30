class UsersController < ApplicationController
  def index
    if params[:search]
      search_txt = params[:search].downcase
      @users = []
      
      User.all.select do |user|
        if user.first_name != ""
          if user.first_name.downcase[search_txt] || user.last_name.downcase[search_txt] || user.username.downcase[search_txt]
            @users << user
          end
        end
      end
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])

    @user_posts = (@user.posts + @user.video_posts).sort_by(&:created_at).reverse!
  end

  private

  def search_params
    params.require(:user).permit(:search)
  end
end
