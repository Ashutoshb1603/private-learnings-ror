module AccountBlock
    class TherapistController < ApplicationController
        before_action :validate_json_web_token
        before_action :get_user
        before_action :check_valid_therapist
        before_action :is_freezed
        include BuilderJsonWebToken::JsonWebTokenValidation
        @@acuity = BxBlockAppointmentManagement::AcuityController.new

        def clients
            accounts = BxBlockRolesPermissions::Role.where('lower(name) = ?', "user").first.accounts.select(:first_name, :email, :id)
            render json: {accounts: accounts}
        end

        def pin_clients
          client_ids = JSON.parse params[:client_ids]
          accounts = AccountBlock::Account.find(client_ids)
          accounts.each do |account|
            account.is_pinned = true
            account.save
          end
          render json: {message: "Clients successfully pinned.", accounts: accounts}
        end

        def unpin_clients
          client_ids = JSON.parse params[:client_ids]
          accounts = AccountBlock::Account.find(client_ids)
          accounts.each do |account|
            account.is_pinned = false
            account.save
          end
          render json: {message: "Clients successfully unnnnpinned.", accounts: accounts}
        end

        def pinned_clients
          accounts = BxBlockRolesPermissions::Role.where('lower(name) = ?', "user").first.accounts.where(is_pinned: true).select(:first_name, :email, :id)
          render json: {accounts: accounts}
        end

        def view_client_notes
            notes = @account.therapist_notes.find_by(account_id: params[:client_id])
            render json: {notes: notes}
        end

        def update_client_notes
            notes = @account.therapist_notes.find_or_initialize_by(account_id: client_notes_params['account_id'])
            notes.update(client_notes_params)
            render json: {notes: notes}
        end

        def client_details
            account = AccountBlock::Account.find(params[:client_id])
            render json: AccountBlock::EmailAccountSerializer.new(account).serializable_hash
        end

        def skin_diary
            @client = AccountBlock::Account.find(params[:client_id])
            if params[:date].present?
              date = Date.parse(params[:date])
              skin_logs = @client.account_choice_skin_logs.where("created_at::date = ?", date).includes(:account, :skin_quiz)
              user_images = @client.user_images.where("created_at::date = ?", date)
            else
              skin_logs = @client.account_choice_skin_logs.where("created_at::date = ?", Date.today).includes(:account, :skin_quiz)
              user_images = @client.user_images.user_images_for_today
            end
            user_images = user_images.map{|user_image|
                          {
                            id: user_image.id,
                            position: user_image.position,
                            image: user_image.image.attached? ? get_image_url(user_image) : nil
                          }}
            render json: BxBlockFacialtracking::UserSkinLogSerializer.new(skin_logs).serializable_hash.merge!(user_images: user_images),
                    status: :ok
        end
      
        def consultation_form_show
            @client = AccountBlock::Account.find(params[:client_id])
            skin_logs = BxBlockFacialtracking::SkinQuiz.where('question_type = ? and active=true', "consultation").left_joins(:account_choice_skin_logs).distinct(:skin_quiz_id)
            render json: BxBlockFacialtracking::ConsultationFormSerializer.new(skin_logs, params: {current_user: @client}).serializable_hash, status: :ok
        end

        def quiz_answer
            @client = AccountBlock::Account.find(params[:client_id])
            if params[:skin_quiz_id].present?
                account_choice_skin_quiz = @client.account_choice_skin_quizzes.find_by(skin_quiz_id: params[:skin_quiz_id])
                render json: {data: {answer: account_choice_skin_quiz.choice.choice}},
                        status: :created
            else
                render json: {errors: {message: "Skin quiz id must present"}},
                        status: :unprocessable_entity
            end
        end

        def skin_goal_answers
            @client = AccountBlock::Account.find(params[:client_id])
            skin_goal_answers = @client.account_choice_skin_goal&.choices&.map(&:choice)
            render json: {data: skin_goal_answers}, status: :ok
        end
    
        def user_skin_goals
            @client = AccountBlock::Account.find(params[:client_id])
            user_skin_goals = @client.account_choice_skin_goal
            render json: BxBlockFacialtracking::UserSkinLogSerializer.new(user_skin_goals).serializable_hash,
                    status: :ok
        end

        def available_dates
            dates = @@acuity.available_dates(@account.acuity_calendar, params[:appointmentTypeID], params[:month])
            render json: {available_dates: dates}
        end
    
        def available_times
            time = @@acuity.available_times(@account.acuity_calendar, params[:appointmentTypeID], params[:date])
            render json: {available_times: time}
        end

        def apppointments_list
            appointments = @@acuity.index(@account.acuity_calendar, params[:minDate], params[:maxDate])
            appointments.map {|a| a["time"] = Time.strptime(a["time"], "%I:%M %P").strftime("%H:%M")
                                a["endTime"] = Time.strptime(a["endTime"], "%I:%M %P").strftime("%H:%M")
                                a["startVideo"] = (Time.parse(a["datetime"]).utc - 15.minutes <= Time.now.utc && Time.parse(a["datetime"]).utc + a["duration"].to_i.minutes >= Time.now.utc) }
            render json: {appointments: appointments}
        end

        def weekly_skin_diary
            @client = AccountBlock::Account.find(params[:client_id])
            if params[:start_date].present?
              date = Date.parse(params[:start_date])
              start_date = date.beginning_of_week
              end_date = date.end_of_week
              user_images = @client.user_images.where("created_at >= ? AND created_at <= ?", start_date, end_date).front
              images = []
              (start_date..end_date).each do |date|
                user_image = user_images.select{|u| u.created_at.to_date == date}.first
                images << { date: date, image: user_image.present? ? get_image_url(user_image) : nil } if user_image.present?
              end
              render json: {data: images}, status: :ok
            else
              render json: {errors: {message: 'Start date of week is not present.'}},
                     status: :unprocessable_entity
            end
          end
      
          def monthly_skin_diary
            @client = AccountBlock::Account.find(params[:client_id])
            @months = []
            year = params[:year] || Time.now.year
            # start_month = (year.present? ? @current_user.account_choice_skin_logs&.select{|a| a.created_at.year.eql?(params[:year].to_i)}&.map{|a| a.created_at.month}&.min : @current_user.account_choice_skin_logs&.map{|a| a.created_at.month}&.min) || 0
            months_and_weeks = []
            data = @client.account_choice_skin_logs.where("extract(year  from created_at) = ?", year).pluck(:created_at)
            data.each do |date|
              month_int = date.month
              month = Date::MONTHNAMES[month_int]
              current_time = date
              beginning_of_the_month = current_time.beginning_of_month
              
              week = current_time.strftime('%U').to_i - beginning_of_the_month.strftime('%U').to_i + 1
              date = date.to_date
              if months_and_weeks[month_int].nil?
                months_and_weeks[month_int] = {month: month}
                months_and_weeks[month_int][:week] = []
                months_and_weeks[month_int][:week][week] = {month: month, week: "WK 0#{week}", start_date: date, end_date: date}
              elsif months_and_weeks[month_int][:week][week].nil?
                months_and_weeks[month_int][:week][week] = {month: month, week: "WK 0#{week}", start_date: date, end_date: date}
              else
                months_and_weeks[month_int][:week][week][:start_date] = date if months_and_weeks[month_int][:week][week][:start_date] > date
                months_and_weeks[month_int][:week][week][:end_date] = date if months_and_weeks[month_int][:week][week][:start_date] < date
              end
            end
            @months = months_and_weeks.compact
            @months.each_with_index do |month, index|
              @months[index][:week] = @months[index][:week].compact
            end
            render json: {data: @months}, status: :ok
          end

        def skin_journey
          @skin_journey = @account.customer_skin_journeys.new(skin_journey_params)
          if @skin_journey.save
            @client = AccountBlock::Account.find_by(id: skin_journey_params[:account_id])
            payload_data = {account: @client, notification_key: 'skin_journey', inapp: true, push_notification: true, redirect: 'skin_journey', type: 'admin', record_id: @skin_journey.id, notification_for: 'skin_journey', key: 'skin_journey'} 
            BxBlockPushNotifications::FcmSendNotification.new("#{@account.name} has updated your skin journey!", "Skin journey updated", @client.device_token, payload_data).call if @client.present?
            render json: {data: @skin_journey}, status: :created
          else
            render json: {errors: @skin_journey.errors}, status: :unprocessable_entity
          end
        end

        def skin_logs
          @client = AccountBlock::Account.find(params[:client_id])
          user_images = @client.user_images.where(position: params[:position]).order(created_at: :desc)
          if params[:page].present?
            begin
              paginated_images = pagy(user_images, page: params[:page], items: 10)
            rescue Pagy::OverflowError => error
                render json: {message: "Page doesn't exist", error: error}, status: 404
            else
                render json: BxBlockFacialtracking::SkinLogSerializer.new(paginated_images.second, meta: {page_data: paginated_images.first}).serializable_hash
            end
          else
            render json: BxBlockFacialtracking::SkinLogSerializer.new(user_images).serializable_hash
          end
        end

        private
        def get_user
            @account = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
            @account = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
            @account
        end
      
        def check_valid_therapist
            account_id = params[:id] || params[:account_id]
            account = AccountBlock::Account.find(account_id) unless @token.account_type == "AdminAccount"
            account = AdminUser.find(account_id) if @token.account_type == "AdminAccount"
            errors = []
            errors = ['Account is not associated to a therapist'] unless @account.role.name.downcase == "admin" or (@account.role.name.downcase == "therapist" and @account.acuity_calendar.present?)
            errors = ['details does not belongs to this therapist'] unless account == @account
            render json: {errors: errors} unless errors.empty?
        end

        def client_notes_params
            params[:data].require("attributes").permit(:account_id, :description)
        end

        def skin_journey_params
            params.require(:data).permit(:account_id, :message, :before_image_url, :after_image_url)
        end
    end

end