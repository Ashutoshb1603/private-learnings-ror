module AccountBlock
	#Otp mailer for update email
	class EmailUpdateOtpMailer < ApplicationMailer
  	def email_otp
			otp_details = params[:otp]
		    @account = params[:account]
		    @email = params[:email]
			@otp = otp_details.pin
		  	@host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
			mail(
			  to: @email,
			  from: 'builder.bx_dev@engineer.ai',
			  subject: 'Intersta Registration OTP') do |format|
			format.html { render 'email_update_otp' }
			end
		end
	end
end
