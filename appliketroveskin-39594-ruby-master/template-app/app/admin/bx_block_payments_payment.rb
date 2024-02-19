ActiveAdmin.register BxBlockPayments::Payment , as: 'Transactions' do

  index do
    column :account_id
    column :status
    column :payment_gateway
    column :price_cents
    column :added_in_wallet
    column :customer_id
    column :charge_id
    column :plan_id
    column "Date" do |object|
      object.created_at
    end
    column "Paid For Subscription" do |object|
      object.plan_id.present?
    end
  end


end

