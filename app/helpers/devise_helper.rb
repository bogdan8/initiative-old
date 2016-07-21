module DeviseHelper
  def devise_error_messages_alert!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
   <div style="display: block;" class="alert alert-danger info">
      <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
      <strong>#{messages}</strong>
      <ul><li>#{sentence}</li></ul>
  </div>
    HTML

    html.html_safe
  end
end
