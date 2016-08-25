class Admin::MicropostsController < ApplicationController



  def index
    @user = User.find(params[:user_id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def show
    @micropost = Micropost.find(params[:id])
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end
end
