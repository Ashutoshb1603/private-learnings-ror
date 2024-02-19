module BxBlockFacialtracking
  class AccountChoiceSkinLogsController < ApplicationController
    before_action :current_user

    def create
      skin_quiz = SkinQuiz.find_by(id: params[:account_choice_skin_log]&.dig(:skin_quiz_id))
      if skin_quiz&.consultation?
        account_choice_skin_log = @current_user.account_choice_skin_logs&.find_by(skin_quiz_id: params[:account_choice_skin_log][:skin_quiz_id]) || @current_user.account_choice_skin_logs&.new(account_choice_skin_log_params)
      elsif skin_quiz&.skin_log?
        account_choice_skin_log = @current_user.account_choice_skin_logs&.where("Date(created_at) = ?",Date.today)&.find_by(skin_quiz_id: params[:account_choice_skin_log][:skin_quiz_id]) || @current_user.account_choice_skin_logs&.new(account_choice_skin_log_params)
      elsif skin_quiz&.skin_goal?
        account_choice_skin_log = @current_user.account_choice_skin_goal || @current_user.create_account_choice_skin_goal(account_choice_skin_log_params)
        BxBlockNotifications::SkinGoalWorker.perform_in(10.minute, @current_user.id)
      else
        account_choice_skin_log = AccountChoiceSkinLog.new(skin_quiz_id: skin_quiz&.id)
      end
      save_result = account_choice_skin_log.present? ? account_choice_skin_log.update(account_choice_skin_log_params) : account_choice_skin_log.save
      if save_result
        render json: AccountChoiceSkinLogSerializer.new(account_choice_skin_log).serializable_hash,
              status: :created
      else
        render json: {errors: {message: account_choice_skin_log.errors.full_messages}},
              status: :unprocessable_entity
      end
    end

    def show
      if params[:date].present?
        date = Date.parse(params[:date])
        skin_logs = @current_user.account_choice_skin_logs.where("account_choice_skin_logs.created_at::date = ?", date).includes(:skin_quiz)
        user_images = @current_user.user_images.where("created_at::date = ?", date)
      else
        skin_logs = @current_user.account_choice_skin_logs.where("account_choice_skin_logs.created_at::date = ?", Date.today).includes(:skin_quiz)
        user_images = @current_user.user_images.user_images_for_today
      end
      user_images = user_images.map{|user_image|
                    {
                      id: user_image.id,
                      position: user_image.position,
                      image: user_image.image.attached? ? get_image_url(user_image) : nil
                    }}
      skin_logs = skin_logs.order('skin_quizzes.created_at')
      uniq_skin_logs = skin_logs.uniq{|skin_log| skin_log.skin_quiz_id}
      render json: UserSkinLogSerializer.new(uniq_skin_logs).serializable_hash.merge!(user_images: user_images),
              status: :ok
    end

    def consultation_form_show
      skin_logs = SkinQuiz.where('question_type = ? and active=true', "consultation").left_joins(:account_choice_skin_logs).distinct(:skin_quiz_id)
      render json: ConsultationFormSerializer.new(skin_logs, params: {current_user: @current_user}).serializable_hash, status: :ok
    end

    def skin_goal_answers
      skin_goal = @current_user.account_choice_skin_goal
      skin_goal_answers = skin_goal&.choices&.map(&:choice) || []
      skin_goal_answers << skin_goal&.other if skin_goal&.other.present?
      render json: {data: skin_goal_answers}, status: :ok
    end

    def user_skin_goals
      user_skin_goals = @current_user.account_choice_skin_goal
      render json: UserSkinLogSerializer.new(user_skin_goals).serializable_hash,
              status: :ok
    end

    private

    def account_choice_skin_log_params
      params.require(:account_choice_skin_log).permit(:skin_quiz_id, :other, :image, choice_ids: [])
    end
  end
end