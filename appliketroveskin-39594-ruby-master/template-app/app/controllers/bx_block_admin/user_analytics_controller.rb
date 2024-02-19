module BxBlockAdmin
    class UserAnalyticsController < ApplicationController 
        before_action :shopify_products
        before_action :shopify_blogs
        
        def conversation_rates
            start_date = params[:start_date]&.to_time&.beginning_of_day || Time.now.beginning_of_month
            end_date = params[:end_date]&.to_time&.end_of_day || Time.now.end_of_month
            users_count = AccountBlock::EmailAccount.count
            users_having_orders = AccountBlock::Account.joins(:orders).where('shopping_cart_orders.created_at >= ? and shopping_cart_orders.created_at <= ?', start_date, end_date).distinct
            users_having_orders_count = users_having_orders&.count
            perc_user_spent_on_orders = (users_having_orders_count*100)/users_count

            elite_users = users_having_orders.reject {|account| account.membership_plan[:plan_type] != "elite"} 
            glow_getter_users = users_having_orders.reject {|account| account.membership_plan[:plan_type] != "glow_getter"} 
            free_users = users_having_orders.reject {|account| account.membership_plan[:plan_type] != "free" || account&.role&.name.downcase != "user"}

            perc_elite = ((elite_users&.count*100.0)/users_having_orders_count).round if users_having_orders_count > 0
            perc_glow_getter = ((glow_getter_users&.count*100.0)/users_having_orders_count).round if users_having_orders_count > 0
            perc_free = ((free_users&.count*100.0)/users_having_orders_count).round if users_having_orders_count > 0

            users_having_appointments = AccountBlock::Account.joins(:appointments).where('appointments.created_at >= ? and appointments.created_at <= ?', start_date, end_date).distinct
            users_having_appointments_count = users_having_appointments&.count
            perc_user_spent_on_appointments = (users_having_appointments_count*100)/users_count

            elite_users_appointments = users_having_appointments.reject {|account| account.membership_plan[:plan_type] != "elite"}
            glow_getter_users_appointments = users_having_appointments.reject {|account| account.membership_plan[:plan_type] != "glow_getter"}
            free_users_appointments = users_having_appointments.reject {|account| account.membership_plan[:plan_type] != "free" || account&.role&.name.downcase != "user"}

            perc_elite_appointments = ((elite_users_appointments&.count*100.0)/users_having_appointments_count).round if users_having_appointments_count > 0
            perc_glow_getter_appointments = ((glow_getter_users_appointments&.count*100.0)/users_having_appointments_count).round if users_having_appointments_count > 0
            perc_free_appointments = ((free_users_appointments&.count*100.0)/users_having_appointments_count).round if users_having_appointments_count > 0

            notifications = BxBlockNotifications::Notification.all
            total_notifications_sent = notifications.count
            opened_notificatons = notifications.read.count

            abandoned_notifications = notifications.where('headings = ? and created_at >= ? and created_at <= ?', "Items in Cart", start_date, end_date).count
            numbers_who_purchased = BxBlockNotifications::Notification.where(purchased: true).count                               
            render json: {
                        data: {
                                conversation_rates: {
                                    users_count: users_count,
                                    perc_of_users_spent_on_app: perc_user_spent_on_orders,
                                    perc_elite: perc_elite,
                                    perc_glow_getter: perc_glow_getter,
                                    perc_free: perc_free
                                },
                                consultation_analytics: {
                                    users_count: users_count,
                                    perc_of_users_spent_on_app: perc_user_spent_on_appointments,
                                    perc_elite: perc_elite_appointments,
                                    perc_glow_getter: perc_glow_getter_appointments,
                                    perc_free: perc_free_appointments
                                },
                                abandoned_carts: {
                                    abandoned_notifications: abandoned_notifications,
                                    numbers_who_purchased: numbers_who_purchased
                                },

                                notifications: {
                                    total_notifications_sent: total_notifications_sent,
                                    opened_notificatons: opened_notificatons
                                }
                            }
                        }
            
        end

        def top_spenders
            if params[:user_type].present? && params[:user_type] == "free" 
                accounts = AccountBlock::Account.all
                members = AccountBlock::Account.joins(:membership_plans).where('membership_plans.end_date > ?', Time.now)
                app_customers = accounts.where.not(id: members.pluck(:id))
            elsif params[:user_type].present? && params[:user_type] != "all"
                plan_type_value = BxBlockCustomisableusersubscriptions::MembershipPlan.plan_types[params[:user_type].to_sym]
                app_customers = AccountBlock::Account.joins(:membership_plans).where('membership_plans.end_date > ? and membership_plans.plan_type = ?', Time.now, plan_type_value)
            else 
                app_customers = AccountBlock::Account.all
            end
            start_date = params[:start_date]&.to_time&.beginning_of_day || Time.now.beginning_of_month
            end_date = params[:end_date]&.to_time&.end_of_day || Time.now.end_of_month

            top_spenders = app_customers.joins(:orders).group(:id).where('shopping_cart_orders.created_at >= ? and shopping_cart_orders.created_at <= ?', start_date, end_date).order('sum(total_price) desc').limit(10)
            total_spent = BxBlockShoppingCart::Order.where('created_at >= ? and created_at <= ?', start_date, end_date)&.sum(:total_price)

            render json: TopSpendersSerializer.new(top_spenders, meta: {total_spent: total_spent})
        end

        def top_favourites
            blogs = BxBlockBlogpostsmanagement::BlogView.all
            top_blog = blogs.group(:blog_id).order('count(blog_id) DESC').count.first(1)[0]
            blogs = @@shopify.blogs["blogs"]
            blog_id = "50963775523"
            blogs.each do |blog|
                blog_id = blog["id"] if blog["title"] == "Corinna's Corner"
            end
            blog = JSON.parse(@@shopify.article(blog_id, top_blog[0])) if top_blog.present?
            tutorial =  BxBlockContentmanagement::Tutorial.all
            top_tutorial = tutorial.joins(:tutorial_views).group(:id).order('count(skin_hub_views.id) DESC').first
            live_videos =  BxBlockContentmanagement::LiveVideo.all
            live_video = live_videos.joins(:video_views).group(:id).order('count(skin_hub_views.id) DESC').first
            products_sold = BxBlockShoppingCart::LineItem.all
            top_product = products_sold.group(:product_id).sum(:quantity).sort_by {|key, value| value}.last
            product = @@shopify_product.product_show(top_product[0])["product"] || nil

            live_views = BxBlockContentmanagement::SkinHubView.where(objectable_type: 'BxBlockContentmanagement::LiveVideo').group(:objectable_id).count.to_h
            average_live_views = live_views.values.sum/live_views.values.count

            elite_value = BxBlockCustomisableusersubscriptions::MembershipPlan.plan_types["elite"]
            glow_getter_value = BxBlockCustomisableusersubscriptions::MembershipPlan.plan_types["glow_getter"]
            
            elite_count = AccountBlock::Account.joins(:membership_plans).where('membership_plans.end_date > ? and membership_plans.plan_type = ?', Time.now, elite_value).count
            glow_getter_count = AccountBlock::Account.joins(:membership_plans).where('membership_plans.end_date > ? and membership_plans.plan_type = ?', Time.now, glow_getter_value).count

            render json: {
                        data: {
                                top_favourites: {
                                    top_blog: {
                                        blog: blog
                                    },
                                    top_tutorial: {
                                        tutorial: top_tutorial
                                    },  
                                    top_live_video:{
                                        live_video: live_video
                                    },
                                    top_product:{
                                        product: product,
                                        favourites: (top_product[1] if top_product.present?)
                                    }
                                },
                                average_live_views: average_live_views,
                                users_split: {
                                    elite_count: elite_count,
                                    glow_getter_count: glow_getter_count
                                }
                            }
                        }
        end
    end
end