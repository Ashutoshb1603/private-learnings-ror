module BxBlockFacialtracking
  class SkinQuizSerializer < BuilderBase::BaseSerializer
    attributes :id, :question, :question_type, :seq_no, :active, :created_at, :updated_at, :info_text, :short_text

    attribute :allows_multiple do |object|
      object.allows_multiple if object.skin_log?
    end

    attribute :choices do |object, params|
      serializer = ChoiceSerializer.new(object.choices, params)
      serializer.serializable_hash[:data]
    end
  end
end