module BxBlockFaqs
  class FaqSerializer < BuilderBase::BaseSerializer
    attributes :id, :question, :answer, :created_at, :updated_at
  end
end