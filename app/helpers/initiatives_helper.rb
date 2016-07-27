module InitiativesHelper
  def show_initiative_categories(initiative)
    initiative.categories.map(&:name).join ', '
  end

  def show_for_confirmation_initiative_path(initiative)
    if initiative.draft? || initiative.rejected?
      link_to t('views.link_to.for_confirmation'), for_confirmation_initiative_path(initiative), class: 'btn btn-info'
    end
  end

  def show_description_on_what_state_initiative(initiative)
    if initiative.draft?
      content_tag :p, 'Чорновик', style: 'color: red;', class: 'initiative-list-title-state'
    elsif initiative.pending_approval?
      content_tag :p, 'Очікується на підтвердження адміністратором',
                  style: 'color: green;', class: 'initiative-list-title-state'
    elsif initiative.rejected?
      content_tag :p, 'Ініціативу відхилено', style: 'color: red;', class: 'initiative-list-title-state'
    elsif initiative.fundraiser?
      content_tag :p, 'Проходить збір коштів', style: 'color: blue;', class: 'initiative-list-title-state'
    elsif initiative.fundraising_finished?
      content_tag :p, 'Підтвердження початку звуті', style: 'color: blue;', class: 'initiative-list-title-state'
    elsif initiative.being_implemented?
      content_tag :p, 'Розпочато подання звіту', style: 'color: blue;', class: 'initiative-list-title-state'
    end
  end

  def check_or_uploaded_picture_initiative(initiative)
    if initiative.main_picture.url(:medium) == '/images/medium/missing.png'
      image_tag 'initiatives/default-initiative-image.jpg', class: 'list-images'
    else
      image_tag initiative.main_picture.url(:medium), class: 'list-images'
    end
  end

  def spinner_css
    html = <<-HTML
     <div class="sk-cube-grid">
      <div class="sk-cube sk-cube1"></div>
      <div class="sk-cube sk-cube2"></div>
      <div class="sk-cube sk-cube3"></div>
      <div class="sk-cube sk-cube4"></div>
      <div class="sk-cube sk-cube5"></div>
      <div class="sk-cube sk-cube6"></div>
      <div class="sk-cube sk-cube7"></div>
      <div class="sk-cube sk-cube8"></div>
      <div class="sk-cube sk-cube9"></div>
     </div>
    HTML

    html.html_safe
  end

  def initiatives_days_left(initiative)
    (initiative.finished_day - DateTime.now.to_date.day).day
  end
end
