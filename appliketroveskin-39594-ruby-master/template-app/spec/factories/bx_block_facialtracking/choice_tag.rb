FactoryBot.define do
  factory :choice_tag, :class => 'BxBlockFacialtracking::ChoiceTag' do

    choice_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    tag_id { 1 }
  end
end
