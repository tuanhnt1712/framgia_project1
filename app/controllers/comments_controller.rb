class CommentsController < ApplicationController
  before_action :load_post

  def create
    @comment = @post.comments.build comment_params
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = t ".create_success"
          redirect_to :back
        end
        format.js
      end
    else
      flash[:danger] = t ".error"
      redirect_to :back
    end
  end

  def destroy
    @comment = @post.comments.find_by id: params[:id]

    @comment.destroy
    respond_to do |format|
      format.html do
        flash[:success] = t ".delete_success"
        redirect_to :back
      end
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content
  end

  def load_post
    @post = Post.find_by id: params[:post_id]
  end
end
