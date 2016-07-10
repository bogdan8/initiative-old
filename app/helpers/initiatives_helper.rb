module InitiativesHelper
  def show_initiative_categories(initiative)
    initiative.categories.map(&:name).join ', '
  end

  def show_for_confirmation_initiative_path(initiative)
    if initiative.create_initiative? || initiative.rejected?
      link_to t('views.link_to.for_confirmation'), for_confirmation_initiative_path(initiative), class: 'btn btn-info'
    end
  end

  def show_description_on_what_state_initiative(initiative)
    if initiative.create_initiative?
      content_tag :p, 'Чорновик', style: 'color: red;'
    elsif initiative.pending_approval?
      content_tag :p, 'Очікується на підтвердження адміністратором', style: 'color: green;'
    elsif initiative.rejected?
      content_tag :p, 'Ініціативу відхилено', style: 'color: red;'
    elsif initiative.fundraiser?
      content_tag :p, 'Проходить збір коштів', style: 'color: blue;'
    end
  end
end
