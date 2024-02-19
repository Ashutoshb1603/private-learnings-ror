module BxBlockSkinClinic
  class PageClick < ApplicationRecord
    self.table_name = 'page_clicks'

    belongs_to :accountable, polymorphic: true
    belongs_to :objectable, polymorphic: true

    def self.increment_click_count(accountable, objectable)
      page_clicks = PageClick.where("created_at >= ?", Time.now.beginning_of_day)
      page_click = page_clicks.where(accountable: accountable, objectable: objectable).first_or_initialize
      page_click.click_count += 1
      page_click.save!
    end

  end
end
