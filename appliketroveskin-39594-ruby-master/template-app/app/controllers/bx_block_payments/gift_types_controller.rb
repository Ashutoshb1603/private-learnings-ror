module BxBlockPayments
    class GiftTypesController < ApplicationController
        before_action :get_user

        def index
            gift_types = GiftType.active
            render json: GiftTypeSerializer.new(gift_types, params: {current_user: @account}).serializable_hash
        end

        def get_user
            @account = AccountBlock::Account.find(@token.id)
            render json: {errors: {message: 'Account is invalid'}} and return unless @account.present? or @token.account_type != "AdminAccount"
        end
    end
end