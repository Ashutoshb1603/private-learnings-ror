module AccountBlock
  class ApplicationController < BuilderBase::ApplicationController
    # protect_from_forgery with: :exception

    include Pagy::Backend
    
    skip_before_action :verify_authenticity_token
    def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << { attribute => error }
      end
      result
    end
  end
end
