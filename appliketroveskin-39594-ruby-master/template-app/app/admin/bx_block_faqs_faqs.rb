ActiveAdmin.register BxBlockFaqs::Faq, as: 'FAQ' do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :question, :answer
  menu label: "FAQs"
  #
  # or
  #
  # permit_params do
  #   permitted = [:question, :answer]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  remove_filter :created_at, :updated_at

  index do
    selectable_column
    column :question
    column "Answer" do |faq|
      raw(faq.answer)
    end
    actions
  end

  show do
    attributes_table do
      row :question
      row :answer do |faq|
        raw(faq.answer)
      end
      row :created_at
      row :updated_at
    end
  end
  
  csv do
    column :question
    column "Answer" do |faq|
      raw(faq.answer)
    end
  end

  form partial: "form"
end
