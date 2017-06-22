class CommentsController < ApplicationController
  before_action :load_post

  def create
    @comment = @post.comments.build comment_params
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = t ".create_success"
      redirect_to :back
    else
      flash[:danger] = t ".error"
      redirect_to :back
    end
  end

  def destroy
    @comment = @post.comments.find_by id: params[:id]

    if @comment.destroy
      flash[:success] = t ".delete_success"
    else
      flash.now[:alert] = t ".failed_delete"
    end
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit :content
  end

  def load_post
    @post = Post.find_by id: params[:post_id]
  end
end
