module BxBlockShopifyintegration
    class ShopifyBlogsController < ApplicationController
           
        def initialize(params)
            @params = params
        end

        def blogs
            endpoint = "/admin/api/2021-04/blogs.json"
            blogs = JSON.parse(get_response(endpoint))
        end

        def articles(id, limit="", search_params="", published_at_min="")
            endpoint = "/admin/api/2021-04/blogs/#{id}/articles.json"
            endpoint += "?limit=#{limit}" if limit.present?
            endpoint += "?published_at_min=#{published_at_min}" if published_at_min.present?
            articles = JSON.parse(get_response(endpoint))
            filtered_articles = search_params.present? ? {"articles" => []} : articles

            if search_params.present? 
                search_params = search_params.downcase
                articles["articles"].each do |article|
                    filtered_articles["articles"] << article if article["title"].downcase.include? search_params or
                                                    article["body_html"].downcase.include? search_params or 
                                                    article["tags"].downcase.include? search_params
                end
            end
            filtered_articles
        end

        def article(blog_id, article_id)
            endpoint = "/admin/api/2021-04/blogs/#{blog_id}/articles/#{article_id}.json"
            article = get_response(endpoint)
        end

        def create(blog_id, article_params)
            endpoint = "/admin/api/2021-04/blogs/#{blog_id}/articles.json"
            article = get_response(endpoint, article_params, "post", "json")
        end

    end
end
