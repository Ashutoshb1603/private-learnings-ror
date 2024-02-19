module BxBlockCfflexapi2
  class GenerateLeonAccessTokenJob < ApplicationJob
    queue_as :default
   
    def perform
      BxBlockCfflexapi2::TokenGenerateService.create_access_token()
    end
  end
end