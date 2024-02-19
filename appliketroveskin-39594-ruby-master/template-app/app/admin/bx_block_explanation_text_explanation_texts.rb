ActiveAdmin.register BxBlockExplanationText::ExplanationText, as: 'ExplanationText' do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :section_name, :area_name, :value

  actions :all, except: [:new, :destroy]

  remove_filter :created_at, :updated_at

  # breadcrumb do
  #   links = [link_to('Admin', admin_root_path)]
  #   if %(new create).include?(params['action'])
  #     links << link_to('Explanation Texts', admin_explanation_texts_path)
  #   end
  #   links
  # end
  #
  # or
  #
  # permit_params do
  #   permitted = [:section_name, :value, :area_name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form partial: "form"

  csv do
    column :section_name
    column :area_name
    column "Value" do |explanation_text|
      raw(explanation_text.value)
    end
  end

  index do
    selectable_column
    column :section_name
    column :area_name
    actions
  end

  show do |explanation_text|
    attributes_table do     
      row :section_name
      row :area_name
      row "Value", class: 'ckeditor-column' do |explanation_text|
        raw(explanation_text.value)
      end
      row :created_at
      row :updated_at
    end
  end
end
