module BxBlockAdmin
    class TopForumUsersSerializer < BuilderBase::BaseSerializer
        attributes :id, :first_name, :last_name, :email

        attribute :posts_count do |object|
            object.questions.count
        end

        attribute :likes_given do |object|
            object&.likes&.count
        end

        attribute :comments_count do |object|
            object&.comments&.count
        end
    end
end