unless User.with_any_role(:admin).any?
  admin = User.new
  admin.email = 'admin@admin.com'
  admin.password = '123456'
  admin.confirmed_at = '2016-07-17 07:35:55.139051'
  admin.confirmation_sent_at = '2016-07-17 07:35:36.292019'
  admin.save
  admin.add_role 'admin'
  puts "Адміністратора добавлено, email(admin@admin.com), password(123456)"
  # add user
  user = User.new
  user.email = 'user@user.com'
  user.password = '123456'
  user.confirmed_at = '2016-07-17 07:35:55.139051'
  user.confirmation_sent_at = '2016-07-17 07:35:36.292019'
  user.save
  user.add_role 'user'
  puts "Користувача добавлено, email(user@user.com), password(123456)"
end
unless Category
  # add category
  category = Category.new
  category.name = 'Місто'
  category.save
  category = Category.new
  category.name = 'Подвіря'
  category.save
  puts "Категорії додані"
end
# add initiatives
initiative = Initiative.new
initiative.title = 'Прибрати вулицю'
initiative.main_video = "<iframe width='100%' height='100%' src='https://www.youtube.com/embed/OaDhY_y8WTo' frameborder='0' allowfullscreen></iframe>"
initiative.short_description = 'На вулиці буде грязно її треба прибрати'
initiative.long_description = 'На вулиці буде грязно її треба прибрати в дуже короткий час та за певну плату'
initiative.sum = 777
initiative.term_fundraiser = 30
initiative.term_report = 15
initiative.aasm_state = 'fundraiser'
initiative.user_id = 2
initiative.save
initiative = Initiative.new
initiative.title = 'Почистити острів'
initiative.main_video = "<iframe width='100%' height='100%' src='https://www.youtube.com/embed/OaDhY_y8WTo' frameborder='0' allowfullscreen></iframe>"
initiative.short_description = 'Почистити острів від бруду'
initiative.long_description = 'Потрібно почистити острів від бруду в дуже короткий термін бажана використовувати для цього лотку та все що мож'
initiative.sum = 2_000
initiative.term_fundraiser = 30
initiative.term_report = 30
initiative.aasm_state = 'fundraiser'
initiative.user_id = 2
initiative.save
puts "Ініціативи додані"
# add initiative_category
initiative_category = InitiativeCategory.new
initiative_category.initiative_id = 1
initiative_category.category_id = 1
initiative_category.save
initiative_category = InitiativeCategory.new
initiative_category.initiative_id = 2
initiative_category.category_id = 2
initiative_category.save
initiative_category = InitiativeCategory.new
initiative_category.initiative_id = 2
initiative_category.category_id = 1
initiative_category.save
puts "Категорії додані до ініціатив"