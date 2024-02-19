module BxBlockAdmin
    class TopTutorialSerializer < BuilderBase::BaseSerializer
        attributes :id, :title, :description

        attribute :views do |object|
            object.tutorial_views.count
        end
    end
end