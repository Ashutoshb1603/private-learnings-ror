module BxBlockEventregistration
    class AccountEventBlockSerializer < BuilderBase::BaseSerializer
  
      attributes *[ :account_id, :event_block_id, :created_at, :updated_at ]
      
    end
  end