module BxBlockCatalogue
    class RecommendedProduct < ApplicationRecord
        self.table_name = :recommended_products
        belongs_to :account, class_name: 'AccountBlock::Account'
        belongs_to :parentable, polymorphic: true, optional: true
        has_many :purchases, class_name: 'BxBlockCatalogue::Purchase'#, dependent: :destroy
        accepts_nested_attributes_for :purchases
        # validates :account_id, uniqueness: { scope: [:title, :parentable],
        # message: "This product is already recommeded to this user by the therapist" }
        # validates :price, exclusion: { in: [0] }
        after_create :update_product_details
        scope :uniq_records, -> (ids) {select('DISTINCT ON (title, account_id) *').where(purchased: true)}
        scope :uniq_records_for_therapist, -> (parent, ids) {select('DISTINCT ON (title, account_id) *').where(parentable: parent, purchased: true)}


        def update_product_details
            shopify = BxBlockShopifyintegration::ShopifyProductsController.new({country: "Ireland"})
            begin
                product_id = self.product_id
                prod = shopify.product_show(product_id, "Ireland")
                prod = shopify.product_show(product_id, "UK") if prod['errors'].present?
                title = prod['product']['title']
                price = prod['product']['variants'][0]['price'].to_d
                self.update(title: title, price: price)
            rescue => e
                return
            end
        end
    end
end
