
ActiveAdmin.register BxBlockCatalogue::HeroProduct, as: "Hero Product" do

    permit_params :tags_type, :tags, :title
    menu label: "Featured Collections"

    controller do

      before_action :editor, :only => :index
  
      def editor
          unless BxBlockCatalogue::HeroProduct.first.present?
            redirect_to action: :new
          else
            redirect_to edit_admin_hero_product_path(id: BxBlockCatalogue::HeroProduct.first.id)
          end
      end
  
      def action_methods
        if BxBlockCatalogue::HeroProduct.first.present?
          super - ['new']
        else
          super
        end
      end
    end
  
  
    index do
      selectable_column 
      column :tags_type
      column :tags
      column :title  
      actions
    end
  
    form do |f|
      f.inputs 'Hero Products'do 
       f.input  :tags_type, :input_html => {:id => "tags_type"}
       f.input :title
       f.input :tags
      end
      actions
    end
  
  
    show do
      attributes_table do
        row :tags_type
        row :title
        row :tags
      end
    end
  
  end
  
