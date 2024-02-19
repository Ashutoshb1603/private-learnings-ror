ActiveAdmin.register_page "Featured Posts" do
    require "uri"
    require "net/http"

    menu label: "Featured Blogs"

    controller do
        def create 
            post_id = params[:id]
            featured = BxBlockBlogpostsmanagement::FeaturedPost.find_by(post_id: post_id)
            if featured.nil?
                BxBlockBlogpostsmanagement::FeaturedPost.create(post_id: post_id)
            else
                featured.delete
            end
            redirect_to admin_featured_posts_path
        end
    end
  
    content do
        shopify_blogs = BxBlockShopifyintegration::ShopifyBlogsController.new(params)
        blogs = shopify_blogs.blogs["blogs"]
        id = params[:blog_id].present? ? params[:blog_id] : blogs.first["id"]
        title = blogs.map{|blog| blog["title"] if blog["id"] == id}.first
        articles = shopify_blogs.articles(id)["articles"]
        featured = BxBlockBlogpostsmanagement::FeaturedPost.all
        
        div class: 'sidebar' do
            div class: 'sidebar_section panel', id: 'filters_sidebar_section' do
              h3 "Filter"
              div class: 'mb-3 d-flex align-items-end filterBlock' do
                div class: 'blogs_div' do
                    select id: 'blog_filter', collection: blogs.map{|a| [a["title"], a["id"]]}, propmt: 'Select Blog'
                  end
                div do
                  link_to "Filter", admin_featured_posts_path, class: 'link', id: "blogs_filter"
                end
              end
              div do
                h2 "#{title}"
              end
            end
          end

        div class: 'paginated_collection' do
            div class: 'paginated_collection_contents' do
                div class: 'index_content' do
                    div class: 'index_as_table customers_table' do
                        table class: "index_table index" do
                            tr do
                                th "Title", class: 'col'
                                th "Author", class: 'col'
                                th "Tags", class: 'col'
                                th "Image", class: 'col'
                                th "Action", class: 'col'
                            end
                            articles.each do |article|
                                is_featured = featured.find_by(post_id: article["id"]).present?
                                    tr do
                                        td article["title"], class: 'col'
                                        td article["author"], class: 'col'
                                        td article["tags"],  class: 'col'
                                        td article["image"].present? ? image_tag(article["image"]["src"], :size => '150') : "", class: 'col'
                                        td link_to is_featured ? "Featured" : "Mark as Featured", admin_featured_posts_path(id: article["id"]), {method: :post, :class=>"button button-#{is_featured} blog" }
                                    end
                            end
                        end
                    end
                end
            end      
        end
    end
end