unless User.with_any_role(:admin).any?
  admin = User.new
  admin.email = 'admin@admin.com'
  admin.password = '123456'
  admin.confirmed_at = '2016-07-17 07:35:55.139051'
  admin.confirmation_sent_at = '2016-07-17 07:35:36.292019'
  admin.save
  admin.add_role 'admin'
end
