class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy, :ajax_comment_create]

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user_id = current_user.id
    @user = User.find(@comment.user_id)

    if @comment.save
      respond_to do |format|
        format.js { render 'comments/ajax_comments_create' }
      end
    else
      puts "******************************"
      puts "FAILED TO SAVE COMMENT"
      puts "******************************"
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])

    @comment = Comment.find(params[:id])
    @comment.user_id = current_user.id
    @comment.update(comment_params)
    flash.notice = "Comment was edited!"
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash.notice = "Comment was deleted!"
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end

  def set_comment
    if Comment.find(params[:id]).user_id != current_user.id
      redirect_to posts_path
    end
  end
end
