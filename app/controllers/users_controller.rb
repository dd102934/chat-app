class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def show
    @user = User.find(params[:id])
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
      redirect_to @user
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
    params.require(:user).permit(:username, :comment, :password,:password_confirmation)
  end
  
  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "自分自身のアカウントのみ変更できます"
      redirect_to root_path
    end
  end
  
  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = "管理者のみ実行可能なアクションです"
      redirect_to root_path
    end
  end
  
end