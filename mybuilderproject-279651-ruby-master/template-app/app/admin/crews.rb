ActiveAdmin.register BxBlockCatalogue::Crew, as: 'Flex Crew Details' do
  actions :index, :show
  
  index do
    selectable_column
    id_column
    column :first_name
    column :middle_name
    column :last_name
    column :pilot
    column :status
    column :job_title
    column :ical_calendar_link
    column :salutation
    column :logname
    column :staffing_plan
    column :gender
    column :airport_code
    column :home_airport_name
    column :home_airport_icao
    column :home_airport_iata
    column :home_airport_faa
    column :home_airport_timezone
    actions
  end

  show do
    attributes_table do
      row :first_name
      row :middle_name
      row :last_name
      row :account_name
      row :nick_name
      row :pilot
      row :status
      row :job_title
      row :weight
      row :height
      row :personnel_number
      row :user_characteristics
      row :ical_calendar_link
      row :salutation
      row :logname
      row :fuzzy_search
      row :notes
      row :staffing_plan
      row :employed_since
      row :accountExpires
      row :birth_date
      row :birth_place
      row :birth_state
      row :picture
      row :staff
      row :gender
      row :employment_type
      row :last_sanctions_date
      row :allowance
      row :allowance_domestic
      row :background_color
      row :catering
      row :commercial_comment
      row :dca
      row :disable_dp_calculation
      row :disable_ft_fdp_calculation
      row :drug_alc
      row :employed_until
      row :has_accidents
      row :has_incidents
      row :important
      row :integration
      row :interest
      row :maintenance_controller
      row :master_crew_list
      row :max_block_hours_per_month
      row :multi_crew_limitation
      row :sifl_type
      row :upload_to_argus
      row :upload_to_wywern
      row :use_custom_footer
      row :airport_id
      row :airport_code
      row :nationality_name
      row :nationality_iso2
      row :nationality_continent
      row :nationality_intname
      row :nationality_capital
      row :nationality_iso3
      row :nationality_ioc
      row :nationality_domain
      row :nationality_currency_code
      row :nationality_phone
      row :home_airport_name
      row :home_airport_icao
      row :home_airport_iata
      row :home_airport_faa
      row :home_airport_local_identifier
      row :home_airport_timezone
      row :operator_name
      row :operator_aocs_name
    end
    panel "Roles" do
      if resource.crew_roles.present?
        table_for resource.crew_roles do
          column :role_type
          column :mandatory_id
          column :label
          column :role_order
          column :filter_id
          column :to_display
          column :roster_filter
        end
      else
        "Not Available"
      end
    end
    panel "Accounts" do
      if resource.crew_accounts.present?
        table_for resource.crew_accounts do
          column :name
          column :operator_name
          column :status
          column :account_number
          column :default_account
        end
      else
        "Not Available"
      end
    end
    panel "Contacts" do
      if resource.crew_contacts.present?
        table_for resource.crew_contacts do
          column :data
          column :contact_type
          column :mains
          column :deleted
        end
      else
        "Not Available"
      end
    end
    panel "Aircrafts Details" do
      if resource.crew_aircrafts.present?
        table_for resource.crew_aircrafts do
          column :aircraft_name
          column :registration
          column :status
          column :last_warning
          column :first_warning
        end
      else
        "Not Available"
      end
    end
    panel "Preferences" do
      if resource.crew_preferences.present?
        table_for resource.crew_preferences do
          column :description
          column :template_name
          column :order
          column :template_show_in_pax
          column :template_show_in_catering
          column :template_show_in_sales
          column :template_show_as_important
        end
      else
        "Not Available"
      end
    end
  end
end