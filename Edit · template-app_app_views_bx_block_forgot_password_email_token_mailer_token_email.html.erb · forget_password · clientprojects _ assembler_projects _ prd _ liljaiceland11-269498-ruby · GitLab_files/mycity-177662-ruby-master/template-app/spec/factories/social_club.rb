FactoryBot.define do
  factory :social_club, class: 'BxBlockSocialClubs::SocialClub' do
      account_id { FactoryBot.create(:Account).id}
      name {"Environment"}
      description {"BlIjoibG9naW4ifQ.-chcl9_AARK7Fc4g. "}
      community_rules {"1.add, 2.diff"}
      location {"sdfsaaaa"}
      is_visible {false}
      user_capacity {10}
      chat_channels {[1, 2]}
      images {[fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'gateway.jpeg'))]}
      interest_ids {[FactoryBot.create(:interest1).id, FactoryBot.create(:interest2).id]}
      bank_name {"Arab bank"}
      bank_account_name {"manoj"}
      bank_account_number {"123456765422"}
      routing_code {"sdfsf"}
      max_channel_count {10}
      fee_amount_cents {10}
      status {"draft"}
  end
end