FactoryBot.define do
  factory :interest2, class: 'BxBlockInterests::Interest' do
    name { "Boating" }
    icon { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'gateway.jpeg')) }
  end
end