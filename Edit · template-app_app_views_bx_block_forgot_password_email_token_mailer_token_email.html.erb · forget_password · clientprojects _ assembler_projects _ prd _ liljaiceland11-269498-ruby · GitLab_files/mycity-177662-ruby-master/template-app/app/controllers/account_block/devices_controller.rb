module AccountBlock
    class DevicesController < ApplicationController
      include BuilderJsonWebToken::JsonWebTokenValidation
      before_action :validate_json_web_token
      rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  
      before_action :set_current_user
  
  
      def index
        render json: {
            data: {
              account: EmailAccountSerializer.new(@account),
              devices: DeviceTokenSerializer.new(@account.devices)
            }
        }
      end
  
      
      def create
        begin
          params[:data] = params[:data].merge(account_id: @account.id)
          device = Device.new(device_params)
          device.save!

          render json: {
            data: {
              account: EmailAccountSerializer.new(@account),
              devices: DeviceTokenSerializer.new(device)
            }
          }, status: :created
        rescue Exception => e
          render json: { errors: e.message },
            status: :unprocessable_entity
        end
      end
  
  
      def update
        device = Device.find(params[:id])
        device.update(device_params)
        render json: {
            data: {
              account: EmailAccountSerializer.new(@account),
              devices: DeviceTokenSerializer.new(device)
            }
        }
      end
  
      def destroy
        device_token = @account.devices.find_by(token: params[:token])
        if device_token.present?
            device_token.destroy!
        end
        render json: {message: "Device token deleted successfully"}
      end
  
      private
  
      def device_params
        params.require(:data).permit(:token, :platform, :account_id)
      end
  
      def set_current_user
        @account ||= AccountBlock::Account.find(@token.id) if @token.present?
      end
  
      def not_found
        render :json => {'errors' => ['Record not found']}, :status => :not_found
      end
    end
  end