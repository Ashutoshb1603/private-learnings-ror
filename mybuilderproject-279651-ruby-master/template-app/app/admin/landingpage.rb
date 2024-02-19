ActiveAdmin.register BxBlockLandingpage::Landingpage, as: 'Landing page' do
	menu parent: 'Content Management System', label: 'Main Landing page'
    config.batch_actions = false
    before_action :valid_landing_page, only: [:create]

  permit_params :description

  form do |f|
    f.inputs  'Landing page' do
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

  show do |valid_landing_page|
    attributes_table do      
      row :description do |valid_landing_page|
        valid_landing_page&.description&.html_safe
      end
    end
  end

  controller do
   def valid_landing_page
   	if BxBlockLandingpage::Landingpage.count >= 8
   		flash[:error] = 'There can only be eight contents'
   		redirect_to "/admin/landingpages"
   	end
   end
   end
end
