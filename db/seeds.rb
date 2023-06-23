# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: "admin@admin",
  password: "aaaaaa"
)

# User.create!(
#   [
#     {
#       nickname: "ナンバ",
#       email: "0@0",
#       is_deleted: false,
#       password: "000000",
#     },
#     {
#       nickname: "シンジュク",
#       email: "1@1",
#       is_deleted: false,
#       password: "111111",
#     },
#     {
#       nickname: "ロッポンギ",
#       email: "2@2",
#       is_deleted: false,
#       password: "222222",
#     }
#   ]
# )
