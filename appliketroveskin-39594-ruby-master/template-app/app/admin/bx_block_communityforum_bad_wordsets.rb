
ActiveAdmin.register BxBlockCommunityforum::BadWordset, as: "Bad Wordset" do

    menu label: 'Bad Wordset'
    menu :parent => "User Moderation Panel", :priority => 1
    permit_params :words

    controller do

      before_action :editor, :only => :index
  
      def editor
          unless BxBlockCommunityforum::BadWordset.first.present?
            redirect_to action: :new
          else
            redirect_to edit_admin_bad_wordset_path(id: BxBlockCommunityforum::BadWordset.first.id)
          end
      end
  
      def action_methods
        if BxBlockCommunityforum::BadWordset.first.present?
          super - ['new']
        else
          super
        end
      end
    end
  
  
    index do
      selectable_column 
      column :words  
      actions
    end
  
    form do |f|
      f.inputs 'Bad Wordset'do 
       f.input  :words
      end
      actions
    end
  
  
    show do
      attributes_table do
        row :words
      end
    end
  
  end
  
