module BxBlockSkinClinic
    class SkinTreatmentLocation < ApplicationRecord
        self.table_name = 'skin_treatment_locations'

        validates :url, format: {with: /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix, message: 'Please enter valid url'}
    end
end
