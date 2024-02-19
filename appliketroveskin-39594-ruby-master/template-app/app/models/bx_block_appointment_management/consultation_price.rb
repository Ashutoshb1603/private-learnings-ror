module BxBlockAppointmentManagement
    class ConsultationPrice < ApplicationRecord
        self.table_name = 'consultation_prices'

        enum currency: {
            'gbp' => 1
        }
    end
end
