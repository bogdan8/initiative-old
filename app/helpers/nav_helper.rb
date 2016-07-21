module NavHelper
  def nav_link(page, &link_text)
    class_name = request.env['PATH_INFO'].match(page) ? 'active' : nil

    content_tag(:li, class: class_name) do
      link_to page do
        link_text.call
      end
    end
  end

  def treeview_link(text, &links)
    content = link_to('#') do
      content_tag(:span, text) <<
        content_tag(:i, '', class: 'fa pull-right fa-angle-left')
    end

    content << content_tag(:ul, class: 'treeview-menu') do
      links.call
    end

    content_tag :li, class: 'treeview' do
      content
    end
  end

  def if_user_signed_show_chose_link_with_text_decoration
    if user_signed_in?
      if request.original_fullpath == root_path
        links = []
        links << content_tag(:li, link_to(t('views.link_to.my_data'), user_panels_information_path, class: 'navbar-a'))
        links << content_tag(:li, link_to(t('views.link_to.my_initiatives'), user_panels_path, class: 'navbar-a'))
        links << content_tag(:li, link_to(t('views.link_to.created'), new_initiative_path, class: 'navbar-a'))
        return links.join
      elsif request.original_fullpath == user_panels_path
        links = []
        links << content_tag(:li, link_to(t('views.link_to.my_data'), user_panels_information_path, class: 'navbar-a'))
        links << content_tag(:li, link_to(t('views.link_to.my_initiatives'), user_panels_path, class: 'navbar-a navbar-a-chose'))
        links << content_tag(:li, link_to(t('views.link_to.created'), new_initiative_path, class: 'navbar-a'))
        return links.join
      elsif request.original_fullpath == user_panels_information_path || request.original_fullpath == edit_user_registration_path
        links = []
        links << content_tag(:li, link_to(t('views.link_to.my_data'), user_panels_information_path, class: 'navbar-a navbar-a-chose'))
        links << content_tag(:li, link_to(t('views.link_to.my_initiatives'), user_panels_path, class: 'navbar-a'))
        links << content_tag(:li, link_to(t('views.link_to.created'), new_initiative_path, class: 'navbar-a'))
        return links.join
      elsif request.original_fullpath == new_initiative_path
        links = []
        links << content_tag(:li, link_to(t('views.link_to.my_data'), user_panels_information_path, class: 'navbar-a'))
        links << content_tag(:li, link_to(t('views.link_to.my_initiatives'), user_panels_path, class: 'navbar-a'))
        links << content_tag(:li, link_to(t('views.link_to.created'), new_initiative_path, class: 'navbar-a navbar-a-chose'))
        return links.join
      else
        links = []
        links << content_tag(:li, link_to(t('views.link_to.my_data'), user_panels_information_path, class: 'navbar-a'))
        links << content_tag(:li, link_to(t('views.link_to.my_initiatives'), user_panels_path, class: 'navbar-a'))
        links << content_tag(:li, link_to(t('views.link_to.created'), new_initiative_path, class: 'navbar-a'))
        return links.join
      end
    else
      content_tag(:li, link_to(t('views.link_to.created'), new_initiative_path, class: 'navbar-a'))
    end
  end

  def if_user_signed_show_index_link_with_text_decoration
    if request.original_fullpath == root_path
      link_to(t('views.link_to.home'), root_path, class: 'navbar-brand navbar-a navbar-a-home navbar-a-chose')
    else
      link_to(t('views.link_to.home'), root_path, class: 'navbar-brand navbar-a navbar-a-home')
    end
  end
end
