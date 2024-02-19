ActiveAdmin.register BxBlockSkinClinic::SkinTreatmentLocation, as: 'Skin Treatment' do

    permit_params :location, :url
  
    index do
      selectable_column
      column :location
      column :url
      actions
    end
  
    form do |f|
      inputs do
        f.input :location
        f.input :url
      end
      actions
    end
    
end
  