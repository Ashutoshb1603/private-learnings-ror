ActiveAdmin.register BxBlockAdmin::TermsAndCondition, as: "Terms And Conditions" do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :description, :description_ar
  #
  # or
  #
  # permit_params do
  #   permitted = [:description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index download_links: [:csv] do 
    selectable_column
    id_column
    column :description
    column :description_ar
    column :created_at
    column :update_at

    actions
  end

  form do |f|
    f.inputs do
      f.input :description, as: :quill_editor, input_html: { data: { options: { modules: { toolbar: [['bold', 'italic','underline', 'strike'],['link', 'image'], [{ 'size': ['small', false, 'large', 'huge'] }],['blockquote', 'code-block'], [{ 'color': [] }, { 'background': [] }],[{ 'font': [] }],[{ 'align': [] }],[{ 'script': 'sub'}, { 'script': 'super' }],[{ 'direction': 'rtl' }],[{ 'header': [1, 2, 3, 4, 5, 6, false] }],] }, placeholder: 'Type something...', theme: 'snow' } } }
      f.input :description_ar, as: :quill_editor, input_html: { data: { options: { modules: { toolbar: [['bold', 'italic','underline', 'strike'],['link', 'image'], [{ 'size': ['small', false, 'large', 'huge'] }],['blockquote', 'code-block'], [{ 'color': [] }, { 'background': [] }],[{ 'font': [] }],[{ 'align': [] }],[{ 'script': 'sub'}, { 'script': 'super' }],[{ 'direction': 'rtl' }],[{ 'header': [1, 2, 3, 4, 5, 6, false] }],] }, placeholder: 'Type something...', theme: 'snow' } } }
    end

    f.actions
  end
  
end
