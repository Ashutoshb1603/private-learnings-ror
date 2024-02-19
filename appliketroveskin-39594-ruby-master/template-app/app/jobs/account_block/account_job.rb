module AccountBlock
  class AccountJob < ApplicationJob
    queue_as :default

    def perform(account_id)
      account = Account.find_by(id: account_id)
      account.update(jwt_token: nil)
    end
  end
end