class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create, :show]
  before_action :load_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :user_admin, only: :destroy

  def index
    @users = User.select(:id, :name, :email).sort_by_id
      .paginate page: params[:page], per_page: Settings.user.users_per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t ".signup_success"
      redirect_to @user
    else
      flash.now[:danger] = ".error_signup"
      render :new
    end
  end

  def show
    @posts = @user.posts.select(:id, :title, :content, :user_id, :created_at) 
      .sort_by_created_at.paginate page: params[:page], 
      per_page: Settings.post.posts_per_page
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      flash.now[:danger] = t ".update_failed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".deleted_user"
      redirect_to users_url
    else
      flash.now[:alert] = t ".delete_failed"
      redirect_to root_path
    end
  end

  def following
    @title = t ".following"
    @user = User.find_by id: params[:id]
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.user.users_per_page
    render :show_follow
  end

  def followers
    @title = t ".followers"
    @user = User.find_by id: params[:id]
    @users = @user.followers.paginate page: params[:page],
      per_page: Settings.user.users_per_page
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    render file: "public/404.html", status: :not_found, layout: false
  end

  def correct_user
    load_user
    
    return if @user.is_user? current_user
    flash[:danger] = t ".correct"
    redirect_to root_url
  end

  def user_admin
    redirect_to root_url unless current_user.is_admin?
  end
end
