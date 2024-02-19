module BxBlockAdmin
    class PostsController < ApplicationController
        before_action :current_user

        def add_or_remove_recommendation
            post_id = params[:post_id]
            post = BxBlockCommunityforum::Question.find(post_id)
            post.update(recommended: !post.recommended)
            render json: {message: "Post recommendation updated"}
        end

    end
end