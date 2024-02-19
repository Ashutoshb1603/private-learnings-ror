module BxBlockFacialtracking
  class ChoiceTag < ApplicationRecord
    self.table_name = :choice_tags

    belongs_to :choice, class_name: 'BxBlockFacialtracking::Choice'
    belongs_to :tag, class_name: 'BxBlockCatalogue::Tag'
  end
end