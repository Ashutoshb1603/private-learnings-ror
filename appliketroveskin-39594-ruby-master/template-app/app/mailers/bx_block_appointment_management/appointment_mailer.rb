module BxBlockAppointmentManagement
    class AppointmentMailer < ApplicationMailer
        def appointment_booked
            @account = params[:account]
            @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
            @datetime = params[:datetime].to_time.strftime("%d %b %Y - %I:%M %P")
            @therapist = params[:therapist]
           
            mail(
                to: @account.email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: 'Your skin consultation with a Skin Deep expert has been booked') do |format|
              format.html { render 'appointment_booked' }
            end
        end

        def appointment_cancelled
            @account = params[:account]
            @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
      
            mail(
                to: @account.email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: 'Your Skin Deep consultation cancellation') do |format|
              format.html { render 'appointment_cancelled' }
            end
        end

        def appointment_rescheduled
            @account = params[:account]
            @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
            @datetime = params[:reschedule_time].to_time.strftime("%d %b %Y - %I:%M %P")
            mail(
                to: @account.email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: 'Your Skin Deep consultation date/time changed') do |format|
              format.html { render 'appointment_rescheduled' }
            end
        end

        def appointment_not_booked
            @account = params[:account]
            @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
            @datetime = DateTime.now.strftime("%d %b %Y - %I:%M %P")
            @error = params[:error]
            mail(
                to: @account.email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: 'Appointment was not scheduled') do |format|
              format.html { render 'appointment_not_booked' }
            end
        end

        def appointment_reminder
          @account = params[:account]
          @date = params[:appointment].date.strftime("%d %B %Y")
          @time = params[:appointment].time
          @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
          
          mail(
              to: @account.email,
              from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
              subject: 'Your Skin Deep consultation reminder!') do |format|
                format.html { render 'appointment_reminder' }
              end
        end

        def appointment_follow_up
          @account = params[:account]
          @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
          
          mail(
              to: @account.email,
              from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
              subject: "Let's progress") do |format|
                format.html { render 'appointment_follow_up' }
              end
        end

    end
end