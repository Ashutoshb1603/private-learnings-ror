# require 'support/files_test_helper'

# FactoryBot.define do 
#   factory :advertisement, class: BxBlockCatalogue::Advertisement do
#     dimension { "347 * 250" }
#     url { "https://tracker.builder.ai/#/projects/1162" }
#     image { Rack::Test::UploadedFile.new('spec/support/assets/1.jpeg', 'image/jpeg') }
#     trait :valid_url do
#       url { "https://tracker.builder.ai/#/projects/1162" }
#     end
#     trait :attach_png_image do
#       image { Rack::Test::UploadedFile.new('spec/support/assets/3.png', 'image/png') }
#     end
#   end
# end
