module BxBlockLogin
  class AccountAdapter
    include Wisper::Publisher

    def login_account(account_params)
      email = account_params.email.downcase
      account = AccountBlock::Account
          .where('LOWER(email) = ?', email)
          .where(:activated => true)
          .first      

      unless account.present?
        broadcast(:account_not_found)
        return
      end

      if account.authenticate(account_params.password)
        token, refresh_token = generate_tokens(account.id)
        broadcast(:successful_login, account, token, refresh_token)
      else
        broadcast(:failed_login)
      end
    end

    def generate_tokens(account_id)
      [
        BuilderJsonWebToken.encode(account_id, 1.months.from_now, token_type: 'login'),
        BuilderJsonWebToken.encode(account_id, 1.year.from_now, token_type: 'refresh')
      ]
    end
  end
end
