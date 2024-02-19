# frozen_string_literal: true

ActiveAdmin.register BxBlockPrivacySettings::TermsAndCondition, as: 'Terms And Conditions' do
  menu parent: 'Content Management System', label: 'Terms And Conditions'
    config.batch_actions = false
    before_action :valid_terms_and_condition, only: [:create]

  permit_params :description

  form do |f|
    f.inputs  'Terms And Conditions' do
       f.input :description, as: :quill_editor, :label => '', input_html: { data:
        { options:
          { modules:
            { toolbar:
              [%w[bold italic underline strike],
               %w[blockquote code-block],
               [{ 'list': 'ordered' }, { 'list': 'bullet' }],
               [{ 'align': [] }],
               ['link'],
               [{ 'size': ['small', false, 'large', 'huge'] }],
               [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
               [{ 'indent': '-1' }, { 'indent': '+1' }],
               [{ 'direction': 'rtl' }],
               [{ 'color': [] }, { 'background': [] }],
               [{ 'font': [] }],
               ['clean'],
               ['image'],
               ['video']] },
            theme: 'snow' } } }
    end
    f.actions
  end

  show do |terms_and_condition|
    attributes_table do      
      row :description do |terms_and_condition|
        terms_and_condition&.description&.html_safe
      end
    end
  end

  controller do
   def valid_terms_and_condition
    if BxBlockPrivacySettings::TermsAndCondition.count >= 1
      flash[:error] = 'There can only be one terms and conditions'
      redirect_to "/admin/terms_and_conditions"
    end
   end
   end
end
