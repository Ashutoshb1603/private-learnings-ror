module BxBlockCategories
  class CategorySerializer < BuilderBase::BaseSerializer
    attributes :id, :name, :created_at, :updated_at

    attribute :sub_categories, if: Proc.new { |record, params|
      params && params[:sub_categories] == true
    }
  end
end
