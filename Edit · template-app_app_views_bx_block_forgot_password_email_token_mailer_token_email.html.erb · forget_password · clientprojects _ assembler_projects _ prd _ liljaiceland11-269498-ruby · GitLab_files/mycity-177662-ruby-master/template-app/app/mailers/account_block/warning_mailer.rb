module AccountBlock
	class WarningMailer < ApplicationMailer
  	
  	def warning_email
		  @account = params[:account]
		  
			mail(
			  to: @account.email,
			  from: 'builder.bx_dev@engineer.ai',
			  subject: 'Account Warning Message') do |format|
					format.html { render 'warning_email' }
				end
		end
	end
end
