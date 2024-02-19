module BxBlockAdmin
  class RepeatedOffenderSerializer < BuilderBase::BaseSerializer
    include JSONAPI::Serializer
    attributes :id, :name, :full_phone_number, :country_code, :phone_number, :email, :gender, :activated, :device, :offensive_posts, :offensive_comments

    attribute :offensive_posts do |object|
      object.questions.offensive.count
    end

    attribute :offensive_comments do |object|
      object.comments.offensive.count
    end
  end
end
