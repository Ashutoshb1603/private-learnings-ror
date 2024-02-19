# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless AdminUser.find_by(email: 'admin@example.com')
  AdminUser.create(email: "admin@example.com", password: "password")
end
AccountBlock::Account.find_or_create_by(email: "ayushig@mailinator.com", full_phone_number: "+919876543212", activated: true, leon_client_id: "63b5d45ea3f3d8.36634412", leon_client_sceret: "74d2097d27f880f27fc2e3d08e354753670cba6204053ce3110d2c12ab39aef2")

BxBlockCfflexapi2::GenerateLeonRefreshTokenJob.perform_later
BxBlockCfflexapi2::GenerateLeonAccessTokenJob.perform_later