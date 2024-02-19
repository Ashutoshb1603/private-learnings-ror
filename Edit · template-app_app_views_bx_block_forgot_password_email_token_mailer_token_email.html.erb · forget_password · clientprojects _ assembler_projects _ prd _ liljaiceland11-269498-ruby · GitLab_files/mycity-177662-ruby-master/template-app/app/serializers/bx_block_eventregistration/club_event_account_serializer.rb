module BxBlockEventregistration
  class ClubEventAccountSerializer < BuilderBase::BaseSerializer

    attributes *[ :account_id, :club_event_id, :created_at, :updated_at, :unique_code ]
    
  end
end