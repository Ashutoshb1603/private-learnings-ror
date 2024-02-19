ActiveAdmin.register BxBlockAppointmentManagement::ConsultationAddonPrice, as: 'Consultation Add on prices' do

    menu label: "Free User Consultation Prices"
    permit_params :addon_price, :weeks, :addon_price_in_pounds

    controller do 
        def index
            if BxBlockAppointmentManagement::ConsultationAddonPrice.count == 0
                redirect_to new_admin_consultation_addonprice_path
            else
                redirect_to edit_admin_consultation_addonprice_path(BxBlockAppointmentManagement::ConsultationAddonPrice.first)
            end
        end
    end

    form do |f|
        f.inputs do
            f.input :addon_price
            f.input :addon_price_in_pounds
            f.input :weeks
        end
        f.actions
    end
  
  end
  