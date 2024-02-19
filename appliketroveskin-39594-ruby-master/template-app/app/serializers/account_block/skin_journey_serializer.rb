module AccountBlock
  class SkinJourneySerializer < BuilderBase::BaseSerializer
    attributes :id, :therapist_id, :account_id, :message, :before_image_url, :after_image_url

    attribute :therapist do |object|
      AccountBlock::Account.find(object.therapist_id)&.name
    end
  end
end