class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def show
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "#{@user.username}さん　チャットアプリの世界にようこそ！ "
      redirect_to chatroom_path
    else
      flash.now[:error] = "登録情報が正しくありません"
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "アカウントの情報を更新しました"
      redirect_to articles_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all articles created by user have been deleted"
    redirect_to users_path
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:username, :password,:password_confirmation)
  end
  
  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end
  
  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = "Only admin users can perform that action"
      redirect_to root_path
    end
  end
  
end