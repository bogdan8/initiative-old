class SearchController < ApplicationController
  before_action :search_initiatives, only: :sort

  def index
    session[:name_initiative] = params[:search]
    search_initiatives
    respond_to_format
  end

  def sort
    @array_initiative_categories = []
    return redirect_to '/search' if @initiatives.empty? || params[:category][:id].empty?
    add_category_with_initiative unless @initiatives.empty? || params[:category][:id].empty?
    respond_to_format
  end

  private

  def search_initiatives
    @initiatives = Initiative.where('title LIKE ?',
                                    "%#{session[:name_initiative]}%").fundraiser
  end

  def add_category_with_initiative
    @initiatives.each do |items|
      @array_initiative_categories << InitiativeCategory.where('category_id = ? AND initiative_id = ?',
                                                               params[:category][:id],
                                                               items.id)
    end
  end
end
