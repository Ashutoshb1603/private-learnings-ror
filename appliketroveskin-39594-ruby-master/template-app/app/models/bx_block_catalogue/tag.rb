module BxBlockCatalogue
  class Tag < BxBlockCatalogue::ApplicationRecord
    self.table_name = :groups

    has_and_belongs_to_many :catalogue, join_table: :catalogues_tags
    has_many                :choice_tags, foreign_key: :tag_id, class_name: 'BxBlockFacialtracking::ChoiceTag', dependent: :destroy
    has_many                :choices, through: :choice_tags, class_name: 'BxBlockFacialtracking::Choice'

    ## Validations
    validates :title, presence: true

    def name
      self.title
    end
  end
end
