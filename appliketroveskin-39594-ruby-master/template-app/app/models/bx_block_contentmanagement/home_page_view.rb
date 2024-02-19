module BxBlockContentmanagement
  class HomePageView < ApplicationRecord
    self.table_name = :home_page_views
    belongs_to :accountable, polymorphic: true
  end
end