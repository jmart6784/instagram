class SavedPostsController < ApplicationController
  def ajax_saved_posts
    @saved_post = SavedPost.find_by(user_id: params[:user_id], post_id: params[:id])

    post = Post.find(params[:id])

    unless current_user.id === post.user_id
      if @saved_post
        @saved_post.destroy
        @save_txt = "Add"
      else
        SavedPost.create!(user_id: params[:user_id], post_id: params[:id])
        @save_txt = "Remove"
      end
    end
  end
end
