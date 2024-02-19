module BxBlockAppointmentManagement
    class AppointmentSerializer < BuilderBase::BaseSerializer
      attributes :id, :appointment_id, :firstname, :lastname, :phone, :email, :date, :time, :endtime, :price, :appointment_type, :calendar, :calendar_id, :canceled, :account_id
    end
  end
  