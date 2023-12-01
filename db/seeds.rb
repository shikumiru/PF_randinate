# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者の追加

Admin.find_or_create_by!(email: "admin@sample.com") do |admin|
  admin.password = ENV["ADMIN_PASSWORD"]
end

# ユーザーの追加

12.times do |n|
  User.create!(
    name: "あにまる#{n + 1}",
    gender: "other",
    is_deleted: false,
    email: "animal#{n + 1}@sample.com",
    password: "password"
  )
end

# サンプル投稿の追加

Coordinate.find_or_create_by!(introduction: "さめのパーカー") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-same.jpg"), filename: 'sample-same.jpg')
  coordinate.user_id = 1
  coordinate.style = "unisex"
  coordinate.is_published = true
  coordinate.tag_list.add("さめ","パーカー")
end

Coordinate.find_or_create_by!(introduction: "黒のパーカー") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-hoodie.jpg"), filename: 'sample-hoodie.jpg')
  coordinate.user_id = 1
  coordinate.style = "unisex"
  coordinate.is_published = false
  coordinate.tag_list.add("黒","パーカー")
end

Coordinate.find_or_create_by!(introduction: "白ストライプシャツ") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-striped.jpg"), filename: 'sample-striped.jpg')
  coordinate.user_id = 1
  coordinate.style = "mens"
  coordinate.is_published = true
  coordinate.tag_list.add("白","ホワイト","ストライプ","シャツ")
end

Coordinate.find_or_create_by!(introduction: "黒のチェックシャツ") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-plaid.jpg"), filename: 'sample-plaid.jpg')
  coordinate.user_id = 1
  coordinate.style = "mens"
  coordinate.is_published = true
  coordinate.tag_list.add("黒","チェック","シャツ")
end

Coordinate.find_or_create_by!(introduction: "かにのポーズで、テスト投稿です") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-kani.jpg"), filename: 'sample-kani.jpg')
  coordinate.user_id = 2
  coordinate.style = "ladies"
  coordinate.is_published = true
  coordinate.tag_list.add("かに","バケハット")
end

Coordinate.find_or_create_by!(introduction: "ワンピースです") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-chiyoda.jpg"), filename: 'sample-chiyoda.jpg')
  coordinate.user_id = 2
  coordinate.style = "ladies"
  coordinate.is_published = true
  coordinate.tag_list.add("ワンピース")
end

Coordinate.find_or_create_by!(introduction: "甚兵衛") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-jinbei.jpg"), filename: 'sample-jinbei.jpg')
  coordinate.user_id = 3
  coordinate.style = "ladies"
  coordinate.is_published = true
  coordinate.tag_list.add("甚兵衛")
end

Coordinate.find_or_create_by!(introduction: "モノクロコーデ") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-monokuro.jpg"), filename: 'sample-monokuro.jpg')
  coordinate.user_id = 3
  coordinate.style = "ladies"
  coordinate.is_published = true
  coordinate.tag_list.add("ジャケット","シャツ","モノクロ")
end

Coordinate.find_or_create_by!(introduction: "ジャンパー") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-jumper.jpg"), filename: 'sample-jumper.jpg')
  coordinate.user_id = 4
  coordinate.style = "mens"
  coordinate.is_published = true
  coordinate.tag_list.add("ジャンパー")
end

Coordinate.find_or_create_by!(introduction: "シャツ") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-shirt.jpg"), filename: 'sample-shirt.jpg')
  coordinate.user_id = 5
  coordinate.style = "mens"
  coordinate.is_published = true
  coordinate.tag_list.add("シャツ")
end

Coordinate.find_or_create_by!(introduction: "デニムスカート") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-minisk.jpg"), filename: 'sample-minisk.jpg')
  coordinate.user_id = 2
  coordinate.style = "ladies"
  coordinate.is_published = true
  coordinate.tag_list.add("デニムスカート")
end

Coordinate.find_or_create_by!(introduction: "グレーパーカー") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-gray.jpg"), filename: 'sample-gray.jpg')
  coordinate.user_id = 2
  coordinate.style = "ladies"
  coordinate.is_published = true
  coordinate.tag_list.add("グレー","パーカー")
end

Coordinate.find_or_create_by!(introduction: "ベージュジャケット") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-beige.jpg"), filename: 'sample-beige.jpg')
  coordinate.user_id = 1
  coordinate.style = "mens"
  coordinate.is_published = true
  coordinate.tag_list.add("ベージュ","ジャケット")
end

# ブックマークの追加

users = User.all
coordinates = Coordinate.all

users.each do |user|
  bookmark_coordinates = coordinates.sample(3)
  bookmark_coordinates.each do |bookmark_coordinate|
    Bookmark.find_or_create_by!(
      user_id: user.id,
      coordinate_id: bookmark_coordinate.id
    )
  end
end