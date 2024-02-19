module BxBlockSkinDiary
    class SkinStoriesController < ApplicationController
        def index
            skin_stories = BxBlockSkinDiary::SkinStory.all
            render json: BxBlockSkinDiary::SkinStoriesSerializer.new(skin_stories).serializable_hash
        end

    end
end
