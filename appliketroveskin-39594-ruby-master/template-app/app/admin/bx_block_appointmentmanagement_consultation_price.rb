ActiveAdmin.register BxBlockAppointmentManagement::ConsultationPrice, as: 'Consultation Prices' do

    menu label: "GBP/£ Consultation"
    permit_params :consultation_id, :currency, :price

    controller do 
        before_action :init_consultation
    
        def init_consultation
          @@acuity = BxBlockAppointmentManagement::AcuityController.new
          @appointments = @@acuity.appointment_types
        end
    end

    index do
        selectable_column
        column :consultation do |consultation|
            appointments.select{|appointment| appointment["id"].to_s == consultation.consultation_id}.first["name"]
        end
        column :currency
        column :price
        actions
    end

    form do |f|
        f.inputs do
            f.input :consultation_id, as: :select, collection: appointments.pluck('name', 'id')
            f.input :currency
            f.input :price
        end
        f.actions
    end
  
  end
  