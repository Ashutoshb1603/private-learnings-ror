module BxBlockCfflexapi2
  class GenerateLeonRefreshTokenJob < ApplicationJob
    queue_as :default
   
    def perform
      BxBlockCfflexapi2::TokenGenerateService.create_refresh_token()
    end
  end
end