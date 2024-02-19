module BxBlockFacialtracking
  class AccountChoiceSkinQuizzesController < ApplicationController
    before_action :current_user

    def create
      account_choice_skin_quiz = @current_user.account_choice_skin_quizzes.new(account_choice_skin_quiz_params)
      save_result = account_choice_skin_quiz.save

      if save_result
        render json: AccountChoiceSkinQuizSerializer.new(account_choice_skin_quiz).serializable_hash,
               status: :created
      else
        render json: {errors: {message: account_choice_skin_quiz.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    def quiz_answer
      if params[:skin_quiz_id].present?
        account_choice_skin_quiz = @current_user.account_choice_skin_quizzes.find_by(skin_quiz_id: params[:skin_quiz_id])
        render json: {data: {answer: account_choice_skin_quiz.choice.choice}},
               status: :created
      else
        render json: {errors: {message: "Skin quiz id must present"}},
               status: :unprocessable_entity
      end
    end

    private

    def account_choice_skin_quiz_params
      params.require(:account_choice_skin_quiz).permit(:account_id, :skin_quiz_id, :choice_id)
    end
  end
end