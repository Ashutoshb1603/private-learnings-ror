module BxBlockFaqs
  class FaqsController < ApplicationController
    def index
      faqs = Faq.all
      render json: FaqSerializer.new(faqs).serializable_hash,
               status: :ok
    end
  end
end