module BxBlockAdmin
    class PageClicksController < BxBlockAdmin::ApplicationController
        def index
            start_date = params[:start_date]&.to_time
            end_date = params[:end_date]&.to_time || Time.now
            salons = BxBlockSkinClinic::SkinClinic.select('skin_clinics.id, name, sum(page_clicks.click_count) as click_count').left_joins(:page_clicks).where('page_clicks.created_at >= ? and page_clicks.created_at <= ?', start_date, end_date).group(:id).all.order('click_count DESC NULLS LAST') if start_date.present?
            advertisements = BxBlockCatalogue::Advertisement.select('advertisements.id, title, sum(page_clicks.click_count) as click_count, advertisements.created_at, advertisements.updated_at, product_id, appointment_id, url').left_joins(:page_clicks).where('page_clicks.created_at >= ? and page_clicks.created_at <= ?', start_date, end_date).group(:id).all.order('click_count DESC NULLS LAST').limit(10) if start_date.present?
            salons = BxBlockSkinClinic::SkinClinic.select('skin_clinics.id, name, sum(page_clicks.click_count) as click_count').left_joins(:page_clicks).group(:id).all.order('click_count DESC NULLS LAST') if !start_date.present?
            advertisements = BxBlockCatalogue::Advertisement.select('advertisements.id, title, sum(page_clicks.click_count) as click_count, advertisements.created_at, advertisements.updated_at, product_id, appointment_id, url').left_joins(:page_clicks).group(:id).all.order('click_count DESC NULLS LAST').limit(10) if !start_date.present?
            advertisements = advertisements.map{ |ad| JSON.parse(ad.to_json) }
            advertisements.map {|ad|
                ad[:click_count] = ad["click_count"].to_i 
                ad[:screen_route] = ad["product_id"].present? ? "NavigationProductViewMessage" : ad["appointment_id"].present? ? "Consultation" : "Link"
            }
            salons.map {|salon| salon[:click_count] = salon[:click_count].to_i }
            users = AccountBlock::Account.where.not(device: nil)
            android_user_perc = (users.android.count*100)/users.count
            ios_user_perc = 100 - android_user_perc
            render json: {
                salons: salons,
                advertisements: advertisements,
                device_split: {
                    android: android_user_perc,
                    ios: ios_user_perc
                }
            }
        end
    end
end