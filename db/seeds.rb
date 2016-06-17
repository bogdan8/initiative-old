# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


unless User.with_any_role(:admin).any?
  admin = User.new
  admin.email = "admin@admin.com"
  admin.password = "123456"
  admin.save
  admin.add_role "admin"
end