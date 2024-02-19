module BxBlockFacialtracking
  class SkinQuizzesController < ApplicationController
    def index
      if params[:question_type].present?
        @skin_quizzes = SkinQuiz.includes(:choices).where(question_type: params[:question_type]).active
      else
        @skin_quizzes = SkinQuiz.active_signup_quizzes.includes(:choices)
      end
      serializer = SkinQuizSerializer.new(@skin_quizzes)
      render json: serializer, status: :ok
    end
  end
end