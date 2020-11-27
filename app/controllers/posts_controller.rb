class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    posts = Post.all
    temp_ary = []
    @sorted_by_likes = []

    posts.each do |post|
      temp_ary << { likes: post.likes.count, post_obj: post }
    end

    temp_ary = (temp_ary.sort_by { |x| x[:likes] }).reverse!
    
    temp_ary.each do |obj|
      @sorted_by_likes << obj[:post_obj]
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      flash.notice = "Successfully created a Post!"
      redirect_to @post
    else 
      flash.now[:danger] = "Can't create this Post, there are errors."
      render "new"
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    @post.update(post_params)
    flash.notice = "Post edited!"
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash.notice = "Post was deleted!"
    redirect_to posts_path
  end

  def following_feed
    @following = current_user.following
    @following_posts = []

    @following.each do |user|
      user.posts.each do |post|
        @following_posts << post
      end
    end

    @sorted_feed = @following_posts.sort_by(&:created_at).reverse!
  end

  def activity
    all_likes = []
    all_comments = []

    current_user.posts.each do |post|
      post.likes.each do |like|
        next if current_user.id === like.user_id
        all_likes << like
      end
    end

    current_user.posts.each do |post|
      post.comments.each do |comment|
        next if current_user.id === comment.user_id
        all_comments << comment
      end
    end

    @activity = (all_likes + all_comments).sort_by(&:created_at).reverse!
  end

  private

  def post_params
    params.require(:post).permit(:caption, :media)
  end

  def set_post
    if Post.find(params[:id]).user != current_user
      redirect_to posts_path
    end
  end
end
