ActiveAdmin.register BxBlockClubEvents::ClubEvent, as: "Club Events" do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :social_club_id, :event_name, :location, :is_visible, :activity_ids, :travel_item_ids,
                :max_participants, :min_participants, :fee_currency, :fee_amount_cents, :description,
                :age_should_be, :start_date_and_time, :end_date_and_time, :start_time, :end_time, 
                :status, :images => []
  #
  # or
  #
  # permit_params do
  #   permitted = [:social_club_id, :event_name, :location, :is_visible, :activities, :max_participants, :fee_currency, :fee_amount_cents, :description, :age_should_be]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index download_links: [:csv] do
    selectable_column
    id_column
    column :event_name
    column :is_visible
    column :activities
    column :travel_items
    column :start_date_and_time
    column :end_date_and_time
    column :status
    column :social_club_id

    actions
  end

  filter :event_name
  filter :is_visible
  filter :status
  filter :age_should_be
  filter :social_club_id

  form do |f|
    f.inputs do
      f.semantic_errors *f.object.errors.keys
      f.input :social_club_id, as: :select, collection: (BxBlockSocialClubs::SocialClub.approved.map{|s| [s.name, s.id] }), prompt: "select any social club"
      f.input :event_name
      f.input :location
      f.input :is_visible, as: :select, collection: [['Public',true], ['Private',false]], prompt: "Choose a Value"
      f.input :activities, as: :select, collection: (BxBlockCategories::Activity.approved.map{|s|[s.name, s.id]}), input_html: { multiple: true }, prompt: "Choose any activities"
      f.input :travel_items, as: :select, collection: (BxBlockCategories::TravelItem.all.map{|s|[s.name, s.id]}), input_html: { multiple: true }, prompt: "Choose any travel item"
      f.input :max_participants, in: 0..1000, step: 1
      f.input :min_participants, in: 0..1000, step: 1
      f.input :fee_amount_cents, in: 1..20, step: :any
      f.input :description
      f.input :age_should_be, in: 0..100, step: 1
      f.input :start_date_and_time, as: :datepicker
      f.input :start_time, as: :time_picker
      f.input :end_date_and_time, as: :datepicker
      f.input :end_time, as: :time_picker
      f.input :images, as: :file, input_html: { multiple: true }
      f.input :status, :collection => [['Draft', :draft], ['Approved', :approved], ['Archieved', :archived], ['Deleted', :deleted]]
    end

    f.actions
  end
  
end

