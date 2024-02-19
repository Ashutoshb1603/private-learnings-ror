module BxBlockAppointmentManagement
    class Appointment < ApplicationRecord
        self.table_name = 'appointments'
        belongs_to :account, class_name: 'AccountBlock::Account'
    end
end
