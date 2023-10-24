# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@admin',
  password: 'password'
  )

5.times do |n|
  User.create!(
    name: "あにまる#{n + 1}",
    gender: "other",
    is_deleted: false,
    email: "animal#{n + 1}@sample.com",
    password: "password"
  )
end

Coordinate.find_or_create_by!(introduction: "さめ") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-same.jpg"), filename: 'sample-same.jpg')
  coordinate.user_id = 1
  coordinate.style = "mens"
  coordinate.is_published = true
end