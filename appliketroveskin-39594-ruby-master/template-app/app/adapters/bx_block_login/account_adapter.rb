module BxBlockLogin
  class AccountAdapter
    include Wisper::Publisher

    def login_account(account_params)
      case account_params.type
      when 'sms_account'
        phone = Phonelib.parse(account_params.full_phone_number).sanitized
        account = AccountBlock::SmsAccount.find_by(
          full_phone_number: phone,
          activated: true)
      when 'email_account'
        email = account_params.email.downcase

        account = AccountBlock::EmailAccount
          .where('LOWER(email) = ? and activated = true', email)
          .first || AdminUser.find_by(email: account_params.email.downcase)
      when 'social_account'
        account = AccountBlock::SocialAccount.find_by(
          email: account_params.email.downcase,
          unique_auth_id: account_params.unique_auth_id,
          activated: true)
      when 'admin_account'
        account = AdminUser.find_by(email: account_params.email.downcase)
      end

      unless account.present?
        broadcast(:account_not_found)
        return
      end
      
      authenticated_user = account.authenticate(account_params.password) if account&.type != "AdminAccount"
      authenticated_user = account.valid_password?(account_params.password) if account&.type == "AdminAccount"
      if authenticated_user
        jwt_token = SecureRandom.hex(4)
        account.update(jwt_token: jwt_token)
        token = BuilderJsonWebToken.encode(account.id, {jwt_token: jwt_token, account_type: account.type}, 1.year.from_now)
        # AccountBlock::AccountJob.set(wait_until: 24.hours.from_now).perform_later(account.id)
        broadcast(:successful_login, account, token)
      else
        broadcast(:failed_login)
      end
    end
  end
end
