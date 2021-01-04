class UsersController < ApplicationController
  def index
    if params[:search]
      search_txt = params[:search].downcase
      @users = []

      search_words = search_txt.split(" ")
      
      User.all.select do |user|
        next if current_user === user

        search_words.each do |word|
          if user.first_name.downcase[word] || user.last_name.downcase[word] || user.username.downcase[word]
            @users << user
          end
        end
      end

      @users.uniq!

    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])

    @user_posts = (@user.posts + @user.video_posts).sort_by(&:created_at).reverse!
  end

  def more_user_show_posts
    @next_start_point = params[:next].to_i
    @user = User.find(params[:id])

    @user_posts = (@user.posts + @user.video_posts).sort_by(&:created_at).reverse!

    temp_ary = []

    21.times do
      next if @user_posts[@next_start_point].nil?
      temp_ary << @user_posts[@next_start_point]
      @next_start_point += 1
    end
    
    @user_posts = temp_ary

    respond_to do |format|
      format.js { render "users/more_user_show_posts" }
    end
  end

  private

  def search_params
    params.require(:user).permit(:search)
  end
end
