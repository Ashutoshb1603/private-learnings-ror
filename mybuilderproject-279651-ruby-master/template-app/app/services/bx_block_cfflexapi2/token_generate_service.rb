module BxBlockCfflexapi2
  module TokenGenerateService
    class << self
      require "uri"
      require "net/http"

      def create_refresh_token
        url = URI("https://man.sandbox.leon.aero/oauth2/code/authorize/?response_type=code&client_id=63b5d45ea3f3d8.36634412&redirect_uri=https://26c3-15-206-64-22.ngrok.io/bx_block_inventorymanagement2/leons/leon_auth_data&scope[0]=GRAPHQL_AIRCRAFT_AVAILABILITY&scope[1]=GRAPHQL_ACFT&scope[2]=GRAPHQL_OPERATOR&scope[3]=GRAPHQL_AIRPORT")
        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(url)
        form_data = [['login', 'ateroid2'],['password', 'kw^A4Ksrmc'],['authorization', '1']]
        request.set_form form_data, 'multipart/form-data'
        response = https.request(request)
        if !(Rails.env.test?)
          location = URI.parse(response["location"])
          data = CGI.parse(location.query)
          code = data['code'].first
          data = "https://26c3-15-206-64-22.ngrok.io/bx_block_inventorymanagement2/leons/leon_auth_data"
          RestClient.get(data, params: {code: code})
        end
      end

      def create_access_token
        account = AccountBlock::Account.find_by(leon_client_id: '63b5d45ea3f3d8.36634412')
        token_url = 'https://man.sandbox.leon.aero/access_token/refresh/'
        response = RestClient.post(token_url, {refresh_token: account.leon_refresh_token})
        account.update_columns(leon_access_token: response.body)
        account
      end
    end
  end
end
