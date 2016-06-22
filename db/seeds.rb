unless User.with_any_role(:admin).any?
  admin = User.new
  admin.email = 'admin@admin.com'
  admin.password = '123456'
  admin.save
  admin.add_role 'admin'
end
