module BxBlockFacialtracking
  class UserImagesController < ApplicationController
    before_action :current_user

    def create
      user_image = @current_user.user_images&.user_images_for_today&.find_by(position: params[:user_image][:position]) || @current_user.user_images.new(user_image_params)
      save_result = user_image.present? ? user_image.update(user_image_params) : user_image.save
      if save_result
        @current_user.update(last_update_log: Date.today)
        render json: UserImageSerializer.new(user_image).serializable_hash,
               status: :created
      else
        render json: {errors: {message: user_image.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    def skin_logs
      user_images = @current_user.user_images.where(position: params[:position]).order(created_at: :desc)
      if params[:page].present?
        begin
          paginated_images = pagy(user_images, page: params[:page], items: 10)
        rescue Pagy::OverflowError => error
            render json: {message: "Page doesn't exist", error: error}, status: 404
        else
            render json: SkinLogSerializer.new(paginated_images.second, meta: {page_data: paginated_images.first}).serializable_hash
        end
      else
        render json: SkinLogSerializer.new(user_images).serializable_hash
      end
    end

    def weekly_skin_diary
      if params[:start_date].present?
        date = Date.parse(params[:start_date])
        start_date = date.beginning_of_week
        end_date = date.end_of_week
        user_images = @current_user.user_images.where("created_at >= ? AND created_at <= ?", start_date, end_date).front
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
      @months = []
      year = params[:year] || Time.now.year
      # start_month = (year.present? ? @current_user.account_choice_skin_logs&.select{|a| a.created_at.year.eql?(params[:year].to_i)}&.map{|a| a.created_at.month}&.min : @current_user.account_choice_skin_logs&.map{|a| a.created_at.month}&.min) || 0
      months_and_weeks = []
      data = @current_user.user_images.where("extract(year  from created_at) = ?", year).pluck(:created_at)
      data.each do |date|
        month_int = date.month
        month = Date::MONTHNAMES[month_int]
        current_time = date
        beginning_of_the_month = current_time.beginning_of_month
        
        week = current_time.strftime('%W').to_i - beginning_of_the_month.strftime('%W').to_i + 1
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

    private

    def user_image_params
      params.require(:user_image).permit(:account_id, :position, :image)
    end

    # def add_weeks_to_months(weeks, date, weeks_for_month, count, month)
    #   weeks.each_with_index do |week, index|
    #     week = week.compact
    #     start_date = Date.new(date.year, date.month, week.first)
    #     end_date =  Date.new(date.year, date.month, week.last)
    #     weeks_for_month << {month: month, week: "WK 0#{count}", start_date: start_date, end_date: end_date }
    #     count = count + 1
    #   end
    #   @months << { month: month, weeks: weeks_for_month} if weeks_for_month.present?
    # end
  end
end