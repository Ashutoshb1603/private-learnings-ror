FactoryBot.define do
  factory :account_choice_skin_quiz, :class => 'BxBlockFacialtracking::AccountChoiceSkinQuiz' do

    skin_quiz_id { 1  }
    account_id { 1  }
    choice_id { 1  }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
