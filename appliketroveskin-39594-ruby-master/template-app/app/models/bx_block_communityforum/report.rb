module BxBlockCommunityforum
  class Report < ApplicationRecord
    self.table_name = :reports
    belongs_to :reportable, polymorphic: true
    belongs_to :accountable, polymorphic: true
  end
end
