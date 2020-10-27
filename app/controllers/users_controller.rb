class UsersController < ApplicationController
  def index
  end

  def new
   @user = User.new
  end

  def create
  end

 def create
   @user = User.new(user_params)
   if @user.save
    log_in @user
    flash[:success] = "会員登録に成功しました"
    redirect_to @user
   else
    flash[:danger] = "会員登録に失敗しました"
    render 'new'
   end
  end


  def show
   @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

   private
    def user_params
     params.require(:user).permit(:name, :email, :password, :password_confirmation)
   end

end
