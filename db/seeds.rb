# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
for i in 1..50
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  name = "#{first_name} #{last_name}"
  email = Faker::Internet.free_email(name)

  user = User.new
  user.email = email
  user.first_name = first_name
  user.last_name = last_name
  user.street_address = Faker::Address.street_address
  user.city = Faker::Address.city
  user.province = Faker::Address.state
  user.postal_code = Faker::Address.postcode
  user.country = Faker::Address.country
  if user.save
    for ii in 1..50
      article = Article.new
      article.user = user
      if article.save
        for iii in 1..10
          article.comment = Faker::Lorem.paragraph
        end
      end
    end
  end
end
