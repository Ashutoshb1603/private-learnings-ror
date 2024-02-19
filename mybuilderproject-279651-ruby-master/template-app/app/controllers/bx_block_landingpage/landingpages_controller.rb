module BxBlockLandingpage
  class LandingpagesController < ApplicationController
    skip_before_action :validate_json_web_token, only: %i[show], raise: false

    def show
      unless BxBlockLandingpage::Landingpage.exists?
        return render json: { message: 'Landingpage not found'}, status: :not_found
      end

      serializer = LandingpagesSerializer.new(Landingpage.all)
      render json: serializer.serializable_hash,
             status: :ok
    end
  end
end
