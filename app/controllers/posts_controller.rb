class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy, :edit, :update]

  def index
    @posts = Post.select(:id, :title, :content, :picture, :user_id, :created_at)
      .sort_by_created_at.paginate page: params[:page],
      per_page: Settings.post.posts_per_page
  end

  def create
    @post = current_user.posts.build post_params

    if @post.save
      flash[:success] = t ".create_post"
      redirect_to :back
    else
      @feed_items = []
      flash.now[:danger] = t ".failed_create"
      render "static_pages/home"
    end
  end

  def edit
  end

  def update
    if @post.update_attributes post_params
      flash[:success] = t ".update_success"
      redirect_to :back
    else
      flash.now[:danger] = t ".update_failed"
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t ".delete_success"
    else
      flash.now[:alert] = t ".failed_delete"
    end
    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit :title, :content, :picture
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]

    redirect_to root_url if @post.nil?
  end
end
