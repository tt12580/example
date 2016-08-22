class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,only: :destroy
  def index
    @microposts = Micropost.all
    if logged_in?
      @micropost = current_user.microposts.build
    end
  end

  def new
    @micropost = Micropost.new
  end

  def show
    @micropost = Micropost.find(params[:id])
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "success"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update(micropost_params)
      flash[:success] = "success"
      redirect_to @micropost
    else
      render 'edit'
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content,:picture)
  end

  def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
  end

  def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
