ActiveAdmin.register BxBlockCategories::Category, as: 'Flex Aircraft Categories' do
  actions :index, :show

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    column :updated_at

    actions
  end

  show do
    attributes_table do
      row :name
      row :created_at
      row :updated_at
    end
  end

  controller do
    def scoped_collection
      BxBlockCategories::Category.where.not(name: ["K12", "Higher Education", "Govt Job", "Competitive Exams", "Upskilling"])
    end
  end
end
