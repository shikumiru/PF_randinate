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

Coordinate.find_or_create_by!(introduction: "さめのパーカーです") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-same.jpg"), filename: 'sample-same.jpg')
  coordinate.user_id = 1
  coordinate.style = "unisex"
  coordinate.is_published = true
  coordinate.tag_list.add("さめ","パーカー")
end

Coordinate.find_or_create_by!(introduction: "ベージュのジャケットです") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-beige.jpg"), filename: 'sample-beige.jpg')
  coordinate.user_id = 1
  coordinate.style = "mens"
  coordinate.is_published = true
  coordinate.tag_list.add("ベージュ","ジャケット")
end

Coordinate.find_or_create_by!(introduction: "黒のパーカーです") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-hoodie.jpg"), filename: 'sample-hoodie.jpg')
  coordinate.user_id = 1
  coordinate.style = "unisex"
  coordinate.is_published = false
  coordinate.tag_list.add("黒","パーカー")
end

Coordinate.find_or_create_by!(introduction: "白のストライプシャツです") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-striped.jpg"), filename: 'sample-striped.jpg')
  coordinate.user_id = 1
  coordinate.style = "mens"
  coordinate.is_published = true
  coordinate.tag_list.add("白","ホワイト","ストライプ","シャツ")
end

Coordinate.find_or_create_by!(introduction: "黒のチェックシャツです") do |coordinate|
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

Coordinate.find_or_create_by!(introduction: "スーツ") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-suit.jpg"), filename: 'sample-suit.jpg')
  coordinate.user_id = 3
  coordinate.style = "unisex"
  coordinate.is_published = true
  coordinate.tag_list.add("スーツ")
end

Coordinate.find_or_create_by!(introduction: "イーブイのパジャマです") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-ev.jpg"), filename: 'sample-ev.jpg')
  coordinate.user_id = 4
  coordinate.style = "unisex"
  coordinate.is_published = true
  coordinate.tag_list.add("イーブイ","パジャマ")
end

Coordinate.find_or_create_by!(introduction: "青のジャージです") do |coordinate|
  coordinate.coordinate_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-dumbo.jpg"), filename: 'sample-dumbo.jpg')
  coordinate.user_id = 5
  coordinate.style = "unisex"
  coordinate.is_published = true
  coordinate.tag_list.add("ジャージ")
end

# ブックマーク機能の

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