# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

## Create User Role Data
BxBlockRolesPermissions::Role.create([{name: 'User'}, {name: 'Admin'}, {name: 'Therapist'}])
BxBlockRolesPermissions::Role.find_by(name: 'Doctor')&.destroy

admin_role = BxBlockRolesPermissions::Role.find_by(name: 'Admin')

admin = AdminUser.find_or_create_by(email: 'admin@skindeep.com')
admin.update(password: 'Skindeep@123', role_id: admin_role.id) if admin.role_id.nil?

tags = BxBlockCommunityforum::QuestionTag.all 

tags.each do |tag|
    tag.delete if tag.question.nil?
end

## Other files for seed
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }

# plans_data = []
# plans =  Stripe::Plan.list.data
# plans.each do |plan|
#   plans_data << {price_cents: plan.amount_decimal, name: plan.nickname, stripe_plan_name: plan.id, interval: plan.interval}
# end
# BxBlockPlan::Plan.destroy_all
# BxBlockPlan::Plan.connection.execute('ALTER SEQUENCE plans_id_seq RESTART WITH 1')
# BxBlockPlan::Plan.create(plans_data)

# BxBlockChat::Chat.where(therapist_id: nil).delete_all

subscriptions = BxBlockPayments::Subscription.where('next_payment_date is NULL or payment_from is NULL')
Stripe.api_key = ENV['STRIPE_SECRET_KEY']
subscriptions.each do |subscription|
    customer = AccountBlock::Account.find(subscription.account_id)
    stripe_customer = Stripe::Customer.retrieve({ id: customer.stripe_customer_id })
    card = Stripe::Customer.retrieve_source(
        stripe_customer.id,
        stripe_customer.default_source,
    )
    subscription.payment_from = card.brand + " - " + card.country
    if subscription[:frequency] == 'daily'
        subscription.next_payment_date = 1.days.from_now
    elsif subscription[:frequency] == 'weekly'
        subscription.next_payment_date = 7.days.from_now
    else
        subscription.next_payment_date = 30.days.from_now
    end
    subscription.save
end

BxBlockCommunityforum::Activity.where(accountable_type: nil).update(accountable_type: 'AccountBlock::Account')
BxBlockCommunityforum::Comment.where(accountable_type: nil).update(accountable_type: 'AccountBlock::Account')
BxBlockCommunityforum::Like.where(accountable_type: nil).update(accountable_type: 'AccountBlock::Account')
BxBlockCommunityforum::Question.where(accountable_type: nil).update(accountable_type: 'AccountBlock::Account')
BxBlockCommunityforum::Saved.where(accountable_type: nil).update(accountable_type: 'AccountBlock::Account')
BxBlockCommunityforum::View.where(accountable_type: nil).update(accountable_type: 'AccountBlock::Account')
BxBlockNotifications::Notification.where(accountable_type: nil).update(accountable_type: 'AccountBlock::Account')
AccountBlock::StoryView.where(accountable_type: nil).update(accountable_type: 'AccountBlock::Account')
uk = BxBlockCatalogue::ProductKey.find_or_create_by(location: "Uk")
uk.update(last_refreshed: DateTime.now)
ireland = BxBlockCatalogue::ProductKey.find_or_create_by(location: "Ireland")
ireland.update(last_refreshed: DateTime.now)
