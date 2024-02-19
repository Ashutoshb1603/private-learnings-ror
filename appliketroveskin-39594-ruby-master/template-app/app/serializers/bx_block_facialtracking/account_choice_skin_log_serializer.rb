module BxBlockFacialtracking
  class AccountChoiceSkinLogSerializer < BuilderBase::BaseSerializer
  attributes :id, :other, :created_at, :updated_at, :account, :skin_quiz
  
    attribute :choices do |object|
      object.choices
    end
  end
end