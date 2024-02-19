namespace :stripe_plans do
  desc "Update Stripe Plans"
  task run: :environment do
    plans_data = []
    plans =  Stripe::Plan.list.data
    plans.each do |plan|
      plans_data << {price_cents: plan.amount, name: plan.nickname, stripe_plan_name: plan.id, interval: plan.interval}
    end
    BxBlockPlan::Plan.destroy_all
    BxBlockPlan::Plan.connection.execute('ALTER SEQUENCE plans_id_seq RESTART WITH 1')
    BxBlockPlan::Plan.create(plans_data)
  end
end
