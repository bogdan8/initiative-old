module InitiativesHelper
  def show_initiative_categories(initiative)
    initiative.categories.map(&:name).join ', '
  end
end
