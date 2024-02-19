module AccountBlock
	class EmailOtpMailer < ApplicationMailer
		def email_otp

			@otp = params[:otp]
			@account = params[:account]
			# debugger
			# @otp=otp_details.pin
			@host=Rails.env.development? ? 'http://localhost:3000':params[:host]
			
			mail( 
				to: @account.email,
				from: 'builder.bx_dev@engineer.ai',
				subject: 'Private Jet Booking App Registration otp') do |format|
					format.html{render 'email_otp'}
				end
		end
	end
end