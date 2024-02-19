FactoryBot.define do
  factory :bad_wordset, :class => 'BxBlockCommunityforum::BadWordset' do

    words { "anal\r\nanus\r\narse\r\nass\r\nballsack\r\nballs\r\nbastard\r\nbitch\r\nbiatch\r\nbloody\r\nblowjob\r\nblow job\r\n" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
