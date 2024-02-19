module BxBlockContactUs
  class ContactSerializer < BuilderBase::BaseSerializer
    attributes *[
        :first_name,
        :last_name,
        :company_name,
        :email,
        :phone_number,
        :description,
        :created_at,
    ]

    # attribute :user do |object|
    #   user_for object
    # end

    # class << self
    #   private

    #   def user_for(object)
    #     "#{object.account.first_name} #{object.account.last_name}"
    #   end
    # end
  end
end
