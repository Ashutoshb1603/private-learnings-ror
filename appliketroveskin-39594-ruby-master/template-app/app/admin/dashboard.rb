module Dashboard
end

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column class: 'div-box' do
        panel "Android Users" do
          AccountBlock::Account.where.not(jwt_token: nil).android.count
        end
      end
      column class: 'div-box' do
        panel "Ios Users" do
          AccountBlock::Account.where.not(jwt_token: nil).ios.count
        end
      end
      column do
      end
    end
    panel "Top Community forum posts" do
      div class: 'mb-3 d-flex align-items-end filterBlock' do
        div do
          label "Start date", class: 'date_label'
          input type: :date, id: 'top_forum_start_date'
        end
        div do
          label "End date", class: 'date_label'
          input type: :date, id: 'top_forum_end_date'
        end
        div do
          link_to "Filter", admin_dashboard_path, class: 'link', id: "top_forum_filter"
        end
      end
      questions = BxBlockCommunityforum::Question.all
      start_date = params[:top_forum_start_date].present? ? params[:top_forum_start_date] : Time.now - 7.days  
      end_date = params[:top_forum_end_date].present? ? params[:top_forum_end_date] : Time.now
      start_date = start_date.to_datetime.beginning_of_day
      end_date = end_date.to_datetime.end_of_day
      h3 "Showing Top 10 posts from #{start_date.strftime("%d %B %Y")} to #{end_date.strftime("%d %B %Y")}"
      filtered_questions = questions.joins(:views).where('views.created_at > ? and views.created_at < ?', start_date, end_date)
      top_10_questions = filtered_questions.group('views.question_id').order('count(views.id) DESC').count.first(10).to_h
      div do
        column_chart top_10_questions.map {|key, value| [questions.find(key).title, value]}
      end
    end

    panel "Top Blog posts" do
      div class: 'mb-3 d-flex align-items-end filterBlock' do
        div do
          label "Start date", class: 'date_label'
          input type: :date, id: 'top_blog_start_date'
        end
        div do
          label "End date", class: 'date_label'
          input type: :date, id: 'top_blog_end_date'
        end
        div do
          link_to "Filter", admin_dashboard_path, class: 'link', id: "top_blogs_filter"
        end
      end
      
      start_date = params[:top_blog_start_date].present? ? params[:top_blog_start_date] : Time.now - 7.days  
      end_date = params[:top_blog_end_date].present? ? params[:top_blog_end_date] : Time.now
      start_date = start_date.to_datetime.beginning_of_day
      end_date = end_date.to_datetime.end_of_day
      blogs = BxBlockBlogpostsmanagement::BlogView.where('created_at > ? and created_at < ?', start_date, end_date)
      top_10_blogs = blogs.group(:blog_id).order('count(blog_id) DESC').count.first(10).to_h
      @shopify = BxBlockShopifyintegration::ShopifyBlogsController.new({country: "Ireland"})
      blogs = @shopify.blogs["blogs"]
      blog_id = "50963775523"
      blogs.each do |blog|
          blog_id = blog["id"] if blog["title"] == "Corinna's Corner"
      end
      blogs = @shopify.articles(blog_id)["articles"]
      top_10_blogs = top_10_blogs.map {|key, value| [blogs.find {|blog| blog["id"].to_s == key}["title"], value]}
      h3 "Showing Top 10 blogs from #{start_date.strftime("%d %B %Y")} to #{end_date.strftime("%d %B %Y")}"
      div do
        column_chart top_10_blogs.map {|key, value| [key, value]}
      end
    end

    panel "Total Views on Community forum" do
      div class: 'mb-3 d-flex align-items-end filterBlock' do
        div do
          label "Start date", class: 'date_label'
          input type: :date, id: 'forum_start_date'
        end
        div do
          label "End date", class: 'date_label'
          input type: :date, id: 'forum_end_date'
        end
        div do
          link_to "Filter", admin_dashboard_path, class: 'link', id: "forum_views_filter"
        end
      end
      start_date = params[:forum_start_date].present? ? params[:forum_start_date] : Time.now - 7.days  
      end_date = params[:forum_end_date].present? ? params[:forum_end_date] : Time.now
      start_date = start_date.to_datetime.beginning_of_day
      end_date = end_date.to_datetime.end_of_day
      views = BxBlockCommunityforum::View.where('created_at > ? and created_at < ?', start_date, end_date)
      div do 
        column_chart views.group_by_day(:created_at).count
      end
    end

    panel "Total Blog post views" do
      div class: 'mb-3 d-flex align-items-end filterBlock' do
        div do
          label "Start date", class: 'date_label'
          input type: :date, id: 'blog_start_date'
        end
        div do
          label "End date", class: 'date_label'
          input type: :date, id: 'blog_end_date'
        end
        div do
          link_to "Filter", admin_dashboard_path, class: 'link', id: "blog_views_filter"
        end
      end
      start_date = params[:blog_start_date].present? ? params[:blog_start_date] : Time.now - 7.days  
      end_date = params[:blog_end_date].present? ? params[:blog_end_date] : Time.now
      start_date = start_date.to_datetime.beginning_of_day
      end_date = end_date.to_datetime.end_of_day
      views = BxBlockBlogpostsmanagement::BlogView.where('created_at > ? and created_at < ?', start_date, end_date)
      div do
        column_chart views.group_by_day(:created_at).count
      end
    end

    panel "Top Spenders" do
      div class: 'mb-3 d-flex align-items-end filterBlock' do
        div do
          label "Start date", class: 'date_label'
          input type: :date, id: 'top_spenders_start_date'
        end
        div do
          label "End date", class: 'date_label'
          input type: :date, id: 'top_spenders_end_date'
        end
        div do
          link_to "Filter", admin_dashboard_path, class: 'link', id: "top_spenders_filter"
        end
      end
      customers = AccountBlock::EmailAccount.all
      start_date = params[:top_spenders_start_date].present? ? params[:top_spenders_start_date] : Time.now - 7.days  
      end_date = params[:top_spenders_end_date].present? ? params[:top_spenders_end_date] : Time.now
      start_date = start_date.to_datetime.beginning_of_day
      end_date = end_date.to_datetime.end_of_day
      filtered_customers = customers.joins(:orders).where('shopping_cart_orders.created_at > ? and shopping_cart_orders.created_at < ?', start_date, end_date)
      top_10_spenders = filtered_customers.group('shopping_cart_orders.customer_id').order('sum(shopping_cart_orders.total_price) DESC').sum('shopping_cart_orders.total_price').first(10).to_h
      h3 "Showing Top 10 Spenders from #{start_date.strftime("%d %B %Y")} to #{end_date.strftime("%d %B %Y")}"
      div do
        column_chart top_10_spenders.map {|key, value| [filtered_customers.find(key).name, value]}
      end
    end

    panel "Sales" do
      div class: 'mb-3 d-flex align-items-end filterBlock' do
        div do
          label "Start date", class: 'date_label'
          input type: :date, id: 'sales_start_date'
        end
        div do
          label "End date", class: 'date_label'
          input type: :date, id: 'sales_end_date'
        end
        div do
          link_to "Filter", admin_dashboard_path, class: 'link', id: "sales_filter"
        end
      end
      start_date = params[:sales_start_date].present? ? params[:sales_start_date] : Time.now - 7.days  
      end_date = params[:sales_end_date].present? ? params[:sales_end_date] : Time.now
      start_date = start_date.to_datetime.beginning_of_day
      end_date = end_date.to_datetime.end_of_day
      sales = BxBlockShoppingCart::Order.where('created_at > ? and created_at < ?', start_date, end_date)
      h3 "Sales from #{start_date.strftime("%d %B %Y")} to #{end_date.strftime("%d %B %Y")}"
      div do
        column_chart sales.group_by_day(:created_at).sum(:total_price)
      end
    end

  end
end
