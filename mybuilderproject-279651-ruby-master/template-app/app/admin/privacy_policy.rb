# frozen_string_literal: true

ActiveAdmin.register BxBlockPrivacySettings::PrivacyPolicy, as: 'Privacy Policies' do
    menu parent: 'Content Management System', label: 'Privacy Policies'
    config.batch_actions = false
    before_action :valid_privacy_policy, only: [:create]

  permit_params :description

  form do |f|
    f.inputs  'Privacy policy' do
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

  show do |valid_privacy_policy|
    attributes_table do      
      row :description do |valid_privacy_policy|
        valid_privacy_policy&.description&.html_safe
      end
    end
  end

  controller do
   def valid_privacy_policy
   	if BxBlockPrivacySettings::PrivacyPolicy.count >= 1
   		flash[:error] = 'There can only be one privacy policy'
   		redirect_to "/admin/privacy_policies"
   	end
   end
   end
end
