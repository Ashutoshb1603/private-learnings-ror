ActiveAdmin.register_page "Invite Elite GlowGetter" do
    require "uri"
    require "net/http"

    menu parent: "Elite GG - Upgrade Requirements", label: "Upgrade to Elite GG", priority: 2
  
    content do
        div class: 'sidebar' do
            div class: 'sidebar_section panel', id: 'filters_sidebar_section' do
              h3 "Filters"
              div class: 'mb-3 d-flex align-items-end filterBlock' do
                div class: 'customer_div' do
                  label "Email"
                 input id: 'email', class: 'form-control'
                end
                div do
                  label "First Name"
                  input id: 'first_name', class: 'form-control'
                end
                div do
                  label "Last Name"
                  input id: 'last_name', class: 'form-control'
                end
                div do
                  link_to "Filter", admin_invite_elite_glowgetter_path, class: 'link', id: "filter_customers"
                end
              end
            end
          end


        shopify_customers = BxBlockShopifyintegration::ShopifyCustomersController.new(params)
        customers = shopify_customers.index["customers"]
        email = params["email"]
        first_name = params["first_name"]
        last_name = params["last_name"]
        app_customers = AccountBlock::Account.all

        filtered_customers = []
        if email || first_name || last_name 
            customers.each do |customer|
                if email.present?
                    filtered_customers << customer if customer["email"] == email
                elsif first_name.present? and last_name.present?
                    filtered_customers << customer if customer["first_name"] == first_name and customer["last_name"] == last_name
                elsif first_name.present?
                    filtered_customers << customer if customer["first_name"] == first_name
                else
                    filtered_customers << customer if customer["last_name"] == last_name
                end
            end
            customers = filtered_customers
        end

        customers = customers.sort_by {|customer| customer["total_spent"].to_d}.reverse

        div class: 'paginated_collection' do
            div class: 'paginated_collection_contents' do
                div class: 'index_content' do
                    div class: 'index_as_table customers_table' do
                        table class: "index_table index" do
                            tr do
                                th "First Name", class: 'col'
                                th "Last Name", class: 'col'
                                th "Email", class: 'col'
                                th "Orders Count", class: 'col'
                                th "Total Spent", class: 'col'
                                th "Total Spent on App", class: 'col'
                                th "App Membership Status", class: 'col'
                                th "Action", class: 'col'
                            end
                            customers.each do |customer|
                                app_customer = app_customers.find_by_email(customer["email"])
                                invite_needed = !(app_customer.present? and app_customer.membership_plan["plan_type"] == "elite")
                                invite_text = (app_customer.present? and app_customer.membership_plan["plan_type"] == "elite") ? "Already an Elite User" : app_customer.present? ? (app_customer.type == "InvitedAccount" ? "Send Reminder" : "Upgrade to Elite") : "Send Elite Invite"
                                    tr do
                                        td customer["first_name"], class: 'col'
                                        td customer["last_name"], class: 'col'
                                        td customer["email"],  class: 'col'
                                        td customer["orders_count"], class: 'col'
                                        td customer["total_spent"], class: 'col'
                                        td app_customer&.orders&.sum(:total_price), class: 'col'
                                        td app_customer.present? ? app_customer.membership_plan[:plan_type].humanize : "Not Registered"
                                        td invite_needed ? (link_to invite_text, send_elite_invite_admin_users_path(email: customer["email"]), {:class=>"button button-#{invite_text.split(" ").last}" }) : invite_text
                                    end
                            end
                        end
                    end
                end
            end      
        end
    end
end