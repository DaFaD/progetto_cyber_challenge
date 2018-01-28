class HomePageController < ApplicationController
  def homepage
    @home_page = Advice.paginate(page: params[:page]).order('id DESC').per_page(2)
  end
end
