FactoryBot.define do
    factory :chat, class: 'BxBlockChat::Chat' do
        social_club_id { FactoryBot.create(:social_club).id }
        chat_type {0}
        name { "social_club_chat" }
        conversation_sid {"aksckjbajs11ascman"}
    end
end