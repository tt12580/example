class Admin::MicropostsController < ApplicationController

  layout 'admin'

  def index
    @microposts = Micropost.
      search_content(params[:content]).
      search_name(params[:name]).
      search_id(params[:id]).
      paginate(page: params[:page])
  end

  def show
    @micropost = Micropost.find(params[:id])
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end
end
