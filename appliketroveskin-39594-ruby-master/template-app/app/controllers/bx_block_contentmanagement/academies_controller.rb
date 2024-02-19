module BxBlockContentmanagement
    class AcademiesController < ApplicationController

        before_action :get_user
        @@klaviyo = BxBlockKlaviyointegration::KlaviyoController.new

        def index
            academies = Academy.order(created_at: :desc)
            begin
                paginated_academies = pagy(academies, page: params[:page], items: 10)
            rescue Pagy::OverflowError => error
                render json: {message: "Page doesn't exist", error: error}, status: 404
            else 
                render json: AcademySerializer.new(paginated_academies.second, params: {current_user: @user}, meta: paginated_academies.first).serializable_hash
            end
        end

        def show
            academy = Academy.find(params[:id])
            render json: AcademySerializer.new(academy, params: {current_user: @user}).serializable_hash
        end

        def purchase
            if @user.type == "AdminAccount"
                render json: {error: "Admin can't purchase!"}, status: 422
            else
                academy = Academy.find(params[:id])
                transaction = CustomerAcademySubscription.find_by_payment_id(params[:payment_id])
                subscription = @user.customer_academy_subscriptions.find_or_create_by(academy_id: academy.id) if transaction.blank?
                subscription.update(payment_id: params[:payment_id]) if transaction.blank?
                if subscription.present?
                    if @user.is_subscribed_to_mailing
                        klaviyo_list = @user.build_klaviyo_list if @user.klaviyo_list.blank?
                        klaviyo_list.save if klaviyo_list.present?
                        @user.klaviyo_list.update(academy: true)
                        subscribe_to_academy_list(@user)
                    end
                    render json: AcademySerializer.new(academy, params: {current_user: @user}).serializable_hash
                else
                    render json: {error: "Payment failed!"}, status: 422
                end
            end
        end

        def create
            if @user.type == "AdminAccount"
                academy = Academy.new(academy_params)
                if academy.save
                    render json: AcademySerializer.new(academy, params: {current_user: @user}).serializable_hash
                else
                    render json: {message: "Can't create academy video.", errors: academy.errors}, status: 422
                end
            else
                render json: {errors: "Admin access required!"}
            end
        end

        def update
            if @user.type == "AdminAccount"
                academy = Academy.find(params[:id])
                if academy.update(academy_params)
                    render json: AcademySerializer.new(academy, params: {current_user: @user}).serializable_hash
                else
                    render json: {message: "Can't update academy video.", errors: academy.errors}, status: 422
                end
            else
                render json: {errors: "Admin access required!"}
            end
        end

        def destroy
            if @user.type == "AdminAccount"
                academy = Academy.find(params[:id])
                if academy.destroy
                    render json: {message: "Academy video deleted successfully."}
                else
                    render json: {message: "Can't delete academy course.", errors: academy.errors}, status: 422
                end
            else
                render json: {errors: "Admin access required!"}
            end
        end

        private
        def academy_params
            params["data"].require(:attributes).permit(:title, :description, :price, :price_in_pounds, :image, academy_videos_attributes: [:id, :title, :description, :url], key_points_attributes: [:id, :description])
        end

        def get_user
            @user = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
            @user = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
            render json: {errors: {message: 'User is invalid'}} and return unless @user.present?
        end

        def subscribe_to_academy_list(user)
            list_id = klaviyo_list_id
            response = @@klaviyo.create_subscriber(list_id, {"email": "#{@account.email}"})
        end

        def klaviyo_list_id
            klaviyo_list = JSON.parse(@@klaviyo.get_list)
            list_id = ""
            klaviyo_list.each do |item|
              if item["list_name"] == "skin_deep_app_academy_users"
                list_id = item["list_id"]
              end
            end
            if list_id == ""
              list_id = JSON.parse(@@klaviyo.create_list("skin_deep_app_academy_users"))["list_id"]
            end
            list_id
        end
    end
end