FactoryBot.define do
  factory :faq, :class => 'BxBlockFaqs::Faq' do

    question { "test123" }
    answer { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
