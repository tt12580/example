class Admin::UsersController < ApplicationController
  layout 'admin'

  def index
    @users = User.
      search_name(params[:name]).
      search_id(params[:id]).
      paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:user_id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def destroy
     @user = User.find(params[:id])
     if @user.destroy
       flash[:success] = "deleted."
       redirect_to root_url
     end
   end

  private

    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end

end
