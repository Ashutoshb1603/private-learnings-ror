ActiveAdmin.register BxBlockFacialtracking::SkinQuiz, as: "Skin Quiz" do
  config.sort_order = "seq_no_asc"

  menu label: "All Skin Quizes"

  scope("All Quiz", default: true){ |scope| scope.where.not(question_type: 'consultation') }
  scope("Sign Up Quiz") { |scope| scope.where(question_type: 'sign_up') }
  scope("Skin Log Quiz") { |scope| scope.where(question_type: 'skin_log') }
  scope("Skin Goal Quiz") { |scope| scope.where(question_type: 'skin_goal') }
  permit_params :question, :short_text, :info_text, :seq_no, :active, :allows_multiple, :question_type, choices_attributes: [:id, :choice, :active, :image, :_destroy, tag_ids: []]

  actions :all, :except => [:destroy]

  filter :allows_multiple
  filter :active

  batch_action :inactive_all do |ids|
    BxBlockFacialtracking::SkinQuiz.where(id: ids).update_all(active: false)
    redirect_to collection_path, notice: 'All selected skin_quiz was inactivated successfully.'
  end

  batch_action :active_all do |ids|
    BxBlockFacialtracking::SkinQuiz.where(id: ids).update_all(active: true)
    redirect_to collection_path, notice: 'All selected skin_quiz was activated successfully.'
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
      item "View", admin_skin_quiz_path(skin_quiz), class: "member_link"
      item "Edit", edit_admin_skin_quiz_path(skin_quiz), class: "member_link"
      item skin_quiz.active ? "Inactive" : "Active", update_status_admin_skin_quiz_path(skin_quiz), method: :put, class: "member_link"
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
      f.input :short_text
      f.input :info_text, as: :ckeditor
      f.input :active
      f.input :question_type, as: :select, collection: BxBlockFacialtracking::SkinQuiz.question_types.reject{|type| type.eql?("consultation")}
      f.input :allows_multiple, wrapper_html: { class: 'allows_multiple' }
      f.has_many :choices, heading: "Choices" do |choice|
        choice.semantic_errors
        choice.input :choice, :input_html => {:rows => 5}
        choice.input :tags, multiple: true, wrapper_html: { class: 'skin_quiz_tags' }
        choice.input :image, as: :file, wrapper_html: { class: 'answer_image' }
        choice.input :active
        choice.input :_destroy, as: :boolean
      end
    end
    actions
  end

  show do |quiz|
    attributes_table do
      row "Active/Inactive SkinQuiz" do
        link_to quiz.active ? "Inactive" : "Active", update_status_admin_skin_quiz_path(quiz), method: :put, class: "link"
      end
      row :seq_no
      row :question
      row :short_text
      row :info_text
      row :question_type
      row :allows_multiple if quiz.skin_log? ||  quiz.skin_goal?
      row :active
      if quiz.choices.present?
        div class: 'panel' do
          h3 'Choices'
          div class: 'attributes_table' do
            table do
              tr class: 'table-header' do
                th 'Choice id'
                th 'Image' if quiz.skin_log? || quiz.skin_goal?
                th 'Choice'
                th 'Active'
                th 'Tags' if quiz.sign_up?
              end
              quiz.choices.each do |choice|
                tr do
                  td choice.id
                  td choice.image.attached? ? image_tag(choice.image) : '' if quiz.skin_log? || quiz.skin_goal?
                  td choice.choice
                  td span.status_tag choice.active
                  td choice.tags.map{|tag| span.status_tag tag.name } if quiz.sign_up?
                end
              end
            end
          end
        end
      end
    end
  end
end
