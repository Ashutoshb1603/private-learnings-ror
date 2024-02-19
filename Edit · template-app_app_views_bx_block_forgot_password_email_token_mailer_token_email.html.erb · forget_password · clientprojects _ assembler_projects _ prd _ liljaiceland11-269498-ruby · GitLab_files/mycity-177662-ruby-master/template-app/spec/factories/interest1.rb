FactoryBot.define do
  factory :interest1, class: 'BxBlockInterests::Interest' do
    name { "Hiking" }
    icon { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'tree.jpg')) }
  end
end