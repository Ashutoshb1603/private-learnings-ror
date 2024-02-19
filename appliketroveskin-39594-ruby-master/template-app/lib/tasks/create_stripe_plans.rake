namespace :create_stripe_plans do
  desc "Create Stripe Plans"
  task run: :environment do

      stripe = Stripe::Plan.create({
        amount_decimal: 7.99,
        interval: "month",
        product: {
          name: "month",
        },
        currency: 'eur',
        id: "month"
      })

      stripe = Stripe::Plan.create({
        amount_decimal: 95.88,
        interval: "year",
        product: {
          name: "year",
        },
        currency: 'eur',
        id: "year"
      })

  end
end
