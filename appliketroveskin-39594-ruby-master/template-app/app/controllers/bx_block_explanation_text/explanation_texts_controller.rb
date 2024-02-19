module BxBlockExplanationText
  class ExplanationTextsController < ApplicationController
    def index
      if params[:screen_name].present?
        skin_quiz = ["Start of skin quiz","End of skin quiz","Advanced Routine","Basic Routine","Become a Glowgetter","My Plan"]
        landing_page = ["Skin Stories","Become a Glowgetter","My Plan","Skin Care Routine","Glowgetter User Skin Care Routine","Supplements"]
        skin_log = ["Track Your Skin","End of skin log","Share your journey","Skin Care Routine","Glowgetter User Skin Care Routine","Supplements"]
        profile = ["My Plan","Delete Account","Log out","Life Event Info","Pregnancy","Life Event","Wedding","Birthday","Wallet From Profile","Skin Care Routine","Glowgetter User Skin Care Routine","Supplements","Wallet","Glow Gift"]
        consultation = ["Consultation Form","Consultation"]
        explanation_texts = case params[:screen_name]
          when 'skin_quiz'
            ExplanationText.where(section_name: skin_quiz)
          when 'landing_page'
            ExplanationText.where(section_name: landing_page)
          when 'skin_log'
            ExplanationText.where(section_name: skin_log)
          when 'profile'
            ExplanationText.where(section_name: profile)
          when 'consultation'
            ExplanationText.where(section_name: consultation)
        end
        render json: ExplanationTextSerializer.new(explanation_texts).serializable_hash,
               status: :ok
      else
        render json: {errors: {message:  "Screen name must be present"}},
               status: :unprocessable_entity
      end
    end
  end
end