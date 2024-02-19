module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # identified_by :current_user
    # include BuilderJsonWebToken::JsonWebTokenValidation

    # def connect
    #   self.current_user = find_verified_user
    #   logger.add_tags 'ActionCable', current_user.name
    # end

    # protected

    # def find_verified_user
    #   current_user = AccountBlock::Account.find(params[:token.id])
    #   if current_user.present?
    #     current_user
    #   else
    #     reject_unauthorized_connection
    #   end
    # end
  end
end
