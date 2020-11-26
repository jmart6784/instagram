class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy, :ajax_comment_create]

  def create
    if params[:video_post_id]
      @comment = Comment.new
      @comment.body = video_comment_params[:body]
      @comment.video_post_id = params[:video_post_id]
      @comment.user_id = current_user.id
      @user = User.find(@comment.user_id)

      if @comment.save
        respond_to do |format|
          format.js { render 'comments/ajax_comments_create' }
        end
      else
        redirect_to VideoPost.find(params[:video_post_id])
      end
    else
      @comment = Comment.new
      @comment.body = comment_params[:body]
      @comment.post_id = params[:post_id]
      @comment.user_id = current_user.id
      @user = User.find(@comment.user_id)

      if @comment.save
        respond_to do |format|
          format.js { render 'comments/ajax_comments_create' }
        end
      else
        redirect_to Post.find(params[:post_id])
      end
    end
  end

  def edit
    if params[:video_post_id]
      @post = VideoPost.find(params[:video_post_id])
    else
      @post = Post.find(params[:post_id])
    end

    @comment = Comment.find(params[:id])
  end

  def update
    if params[:video_post_id]
      @post = Post.find(params[:video_post_id])
      @comment = Comment.find(params[:id])
      @comment.user_id = current_user.id
      @comment.update(video_comment_params)
      flash.notice = "Comment was edited!"
      redirect_to video_post_path(@post)
    else
      @post = Post.find(params[:post_id])
      @comment = Comment.find(params[:id])
      @comment.user_id = current_user.id
      @comment.update(comment_params)
      flash.notice = "Comment was edited!"
      redirect_to post_path(@post)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.video_post_id
      @post = VideoPost.find(@comment.video_post_id)
      flash.notice = "Comment was deleted!"
      redirect_to video_post_path(@post)
    else
      @post = Post.find(@comment.post_id)
      flash.notice = "Comment was deleted!"
      redirect_to post_path(@post)
    end

    @comment.destroy
  end

  private

  def video_comment_params
    params.require(:comment).permit(:body, :user_id, :video_post_id)
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end

  def set_comment
    if Comment.find(params[:id]).user_id != current_user.id
      redirect_to posts_path
    end
  end
end
