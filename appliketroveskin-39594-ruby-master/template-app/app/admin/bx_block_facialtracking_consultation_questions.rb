ActiveAdmin.register BxBlockFacialtracking::SkinQuiz, as: "Consultation Questions" do
  config.sort_order = "seq_no_asc"

  permit_params :question, :info_text, :seq_no, :acuity_field_id, :active, :allows_multiple, question_type: 'consultation', choices_attributes: [:id, :choice, :active, :image, :_destroy]

  actions :all, :except => [:destroy]

  filter :allows_multiple
  filter :active

  batch_action :inactive_all do |ids|
    BxBlockFacialtracking::SkinQuiz.where(id: ids).update_all(active: false)
    redirect_to collection_path, notice: 'All selected consultation questions was inactivated successfully.'
  end

  batch_action :active_all do |ids|
    BxBlockFacialtracking::SkinQuiz.where(id: ids).update_all(active: true)
    redirect_to collection_path, notice: 'All selected consultation questions was activated successfully.'
  end

  # breadcrumb do
  #   links = [link_to('Admin', admin_root_path)]
  #   if %(new create).include?(params['action'])
  #     links << link_to('Skin Quizzes', admin_skin_quizzes_path)
  #   end
  #   links
  # end

  csv do
    column :seq_no
    column :question
    column :question_type
    column :allows_multiple
    column :active
  end

  member_action :update_status, method: [:put, :patch] do
    resource.update(active: resource.active ? false : true)
    redirect_to resource_path, notice: "SkinQuiz was successfully #{resource.active ? "activated" : "inactivated"}."
  end

  index do
    selectable_column
    column :seq_no
    column :question
    column :question_type
    column :allows_multiple
    column :active
    actions defaults: false do |skin_quiz|
      item "View", admin_consultation_question_path(skin_quiz), class: "member_link"
      item "Edit", edit_admin_consultation_question_path(skin_quiz), class: "member_link"
      item skin_quiz.active ? "Inactive" : "Active", update_status_admin_consultation_question_path(skin_quiz), method: :put, class: "member_link"
    end
  end

  filter :question

  form do |f|
    inputs 'SkinQuiz' do
      f.semantic_errors *f.object.errors.keys
      maximum = BxBlockFacialtracking::SkinQuiz.maximum("seq_no")
      seqs = Array(1..maximum)
      available_seqs = seqs - BxBlockFacialtracking::SkinQuiz.all.map(&:seq_no)
      minimum = maximum - maximum % 10 if maximum.present?
      range = (minimum.present? && minimum > 0) ? (maximum == minimum ? ((maximum + 1)..(maximum + 10)).step(1) : ((minimum + 1)..(maximum.ceil(-1))).step(1)) : (1..10).step(1)
      f.input :seq_no, as: :select, collection: available_seqs.present? && seqs.present? ? seqs : range, prompt: "Select seq no", disabled: BxBlockFacialtracking::SkinQuiz.all.map(&:seq_no)
      f.input :question, :input_html => {:rows => 5}
      f.input :info_text
      f.input :acuity_field_id, label: "AcuityId (for acuity form mapping, should not be changed)"
      f.input :active
      f.input :allows_multiple
      f.has_many :choices, heading: "Choices" do |choice|
        choice.semantic_errors
        choice.input :choice, :input_html => {:rows => 5}
        choice.input :active
        choice.input :_destroy, as: :boolean
      end
    end
    actions
  end

  show do |quiz|
    attributes_table do
      row "Active/Inactive SkinQuiz" do
        link_to quiz.active ? "Inactive" : "Active", update_status_admin_consultation_question_path(quiz), method: :put, class: "link"
      end
      row :seq_no
      row :question
      row :info_text
      row :question_type
      row :allows_multiple
      row :active
      row :acuity_field_id
      if quiz.choices.present?
        div class: 'panel' do
          h3 'Choices'
          div class: 'attributes_table' do
            table do
              tr class: 'table-header' do
                th 'Choice id'
                th 'Choice'
                th 'Active'
              end
              quiz.choices.each do |choice|
                tr do
                  td choice.id
                  td choice.choice
                  td span.status_tag choice.active
                end
              end
            end
          end
        end
      end
    end
  end

  controller do
    def scoped_collection
      BxBlockFacialtracking::SkinQuiz.consultation
    end
  end
end
