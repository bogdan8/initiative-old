class SearchController < ApplicationController
  before_action :search_initiatives, only: :sort

  def index
    session[:name_initiative] = params[:search]
    search_initiatives
  end

  def sort
    @array_initiative_categories = []
    if @initiatives.empty? || params[:category][:id].empty?
      redirect_to '/search'
    else
      @initiatives.each do |items|
        @array_initiative_categories << InitiativeCategory.where('category_id = ? AND initiative_id = ?',
                                                                 params[:category][:id],
                                                                 items.id)
      end
    end
  end

  private

  def search_initiatives
    @initiatives = Initiative.where('title LIKE ?', "%#{session[:name_initiative]}%").order(created_at: :desc)
  end
end
