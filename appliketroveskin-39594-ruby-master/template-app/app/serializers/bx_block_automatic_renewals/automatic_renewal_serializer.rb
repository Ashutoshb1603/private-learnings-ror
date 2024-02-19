module BxBlockAutomaticRenewals
  class AutomaticRenewalSerializer < BuilderBase::BaseSerializer
    include FastJsonapi::ObjectSerializer
    attributes *[
      :id,
      :subscription_type,
      :is_auto_renewal,
      :updated_at,
      :created_at,
      :account,
    ]
  end
end
