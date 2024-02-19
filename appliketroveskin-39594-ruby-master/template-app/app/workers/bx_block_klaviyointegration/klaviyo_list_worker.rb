module BxBlockKlaviyointegration
    class KlaviyoListWorker
        include Sidekiq::Worker

        def initialize
            @klaviyo = BxBlockKlaviyointegration::KlaviyoController.new
            @lists = []
        end

        def perform()
            accounts = AccountBlock::Account.all
            accounts.each do |account|
                if account.is_subscribed_to_mailing == true
                    klaviyo_obj = account.build_klaviyo_list if account.klaviyo_list.blank?
                    klaviyo_obj.save if klaviyo_obj.present?


                    membership = account.membership_plan[:plan_type]
                    klaviyo_membership_list = account.klaviyo_list.membership_list

                    if membership != klaviyo_membership_list
                        if klaviyo_membership_list != "unsubscribed"
                            membership_list = "skin_deep_app_#{klaviyo_membership_list}_users"
                            membership_list_id = klaviyo_list_id(membership_list)
                            response = @klaviyo.unsubscribe(membership_list_id, account.email)
                        end

                        membership_list = "skin_deep_app_#{membership}_users"
                        membership_list_id = klaviyo_list_id(membership_list)
                        response = @klaviyo.create_subscriber(membership_list_id, {"email": "#{account.email}"})
                    end

                    purchased_academy = account.customer_academy_subscriptions.present?
                    if purchased_academy
                        academy_list_id = klaviyo_list_id('skin_deep_app_academy_users')
                        response = @klaviyo.create_subscriber(academy_list_id, {"email": "#{account.email}"})
                    end

                    klaviyo_new = account.klaviyo_list.new
                    remove = account.created_at < 7.days.ago
                    if klaviyo_new && remove
                        new_list_id = klaviyo_list_id('skin_deep_app_new_users')
                        response = @klaviyo.unsubscribe(new_list_id, account.email)
                    end

                    klaviyo_not_active = account.klaviyo_list.not_active_since_6_months
                    active = account.updated_at > 6.months.ago

                    status = "false"
                    if active && klaviyo_not_active != "false"
                        not_active_list_id = klaviyo_list_id("skin_deep_app_not_active_#{klaviyo_not_active}")
                        response = @klaviyo.unsubscribe(not_active_list_id, account.email)
                        status = "false"
                    elsif !active
                        if klaviyo_not_active == 'false'
                            not_active_list_id = klaviyo_list_id("skin_deep_app_not_active_#{membership}_list")
                            response = @klaviyo.create_subscriber(not_active_list_id, {"email": "#{account.email}"})
                        elsif klaviyo_not_active != "#{membership}_list"
                            not_active_list_id = klaviyo_list_id("skin_deep_app_not_active_#{klaviyo_not_active}")
                            response = @klaviyo.unsubscribe(not_active_list_id, account.email)
                            not_active_list_id = klaviyo_list_id("skin_deep_app_not_active_#{membership}_list")
                            response = @klaviyo.create_subscriber(not_active_list_id, {"email": "#{account.email}"})
                        end
                        status = "#{membership}_list"
                    end
                    account.klaviyo_list.update(membership_list: membership, academy: purchased_academy, not_active_since_6_months: status, new: remove)
                else
                    klaviyo_obj = account.build_klaviyo_list if account.klaviyo_list.blank?
                    klaviyo_obj.save if klaviyo_obj.present?
                    membership = account.membership_plan[:plan_type] + "_members_with_non_subscribed"
                    klaviyo_membership_list = account.klaviyo_list.non_subscribed_members_list

                    if membership != klaviyo_membership_list
                        if klaviyo_membership_list != "not_added"
                            membership_list = "skin_deep_app_#{klaviyo_membership_list}"
                            membership_list_id = klaviyo_list_id(membership_list)
                            response = @klaviyo.unsubscribe(membership_list_id, account.email)
                        end

                        membership_list = "skin_deep_app_#{membership}"
                        membership_list_id = klaviyo_list_id(membership_list)
                        response = @klaviyo.create_subscriber(membership_list_id, {"email": "#{account.email}"})
                    end
                    account.klaviyo_list.update(non_subscribed_members_list: membership)
                end

            end

        end

        private

        def subscribe(list_id, email)
            response = @klaviyo.create_subscriber(list_id, {"email": "#{email}"})
        end

        def unsubscribe(list_id, email)
            response = @klaviyo.unsubscribe(list_id, email)
        end

        def klaviyo_list_id(list_name)
            @lists = JSON.parse(@klaviyo.get_list) if @lists.blank?
            list_id = ""
            @lists.each do |item|
              if item["list_name"] == list_name
                list_id = item["list_id"]
              end
            end
            if list_id == ""
              list_id = JSON.parse(@klaviyo.create_list(list_name))["list_id"]
              @lists << {"list_id": list_id, "list_name": list_name}.with_indifferent_access
            end
            list_id
        end

    end
end