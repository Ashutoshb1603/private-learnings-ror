class CreateCrews < ActiveRecord::Migration[6.0]
  def change
    create_table :crews do |t|
      t.bigint :flex_crew_id
    	t.string :first_name
    	t.string :middle_name
    	t.string :last_name
    	t.string :account_name
    	t.string :nick_name
    	t.boolean :pilot
    	t.string :status
    	t.string :job_title
    	t.float :weight
    	t.float :height
    	t.string :personnel_number
    	t.string :user_characteristics
    	t.string :ical_calendar_link
    	t.string :salutation
    	t.string :logname
    	t.boolean :fuzzy_search
    	t.string :notes
      t.string :staffing_plan
      t.string :employed_since
      t.string :accountExpires
      t.string :birth_date
      t.string :birth_place
      t.string :birth_state
      t.string :picture
      t.string :staff
      t.string :gender
      t.string :employment_type
      t.string :last_sanctions_date
      t.integer :allowance
      t.integer :allowance_domestic
      t.string :background_color
      t.string :catering
      t.string :commercial_comment
      t.boolean :dca
      t.boolean :disable_dp_calculation
      t.boolean :disable_ft_fdp_calculation
      t.boolean :drug_alc
      t.string :employed_until
      t.boolean :has_accidents
      t.boolean :has_incidents
      t.string :important
      t.string :integration
      t.string :interest
      t.string :maintenance_controller
      t.boolean :master_crew_list
      t.integer :max_block_hours_per_month
      t.boolean :multi_crew_limitation
      t.string :sifl_type
      t.boolean :upload_to_argus
      t.boolean :upload_to_wywern
      t.boolean :use_custom_footer
      t.bigint :airport_id
      t.string :airport_code
      t.string :nationality_name
      t.string :nationality_iso2
      t.string :nationality_continent
      t.string :nationality_intname
      t.string :nationality_capital
      t.string :nationality_iso3
      t.string :nationality_ioc
      t.string :nationality_domain
      t.string :nationality_currency_code
      t.string :nationality_phone
      t.string :home_airport_name
      t.string :home_airport_icao
      t.string :home_airport_iata
      t.string :home_airport_faa
      t.string :home_airport_local_identifier
      t.string :home_airport_timezone
      t.string :operator_name
      t.string :operator_aocs_name

    	t.timestamps
    end
  end
end