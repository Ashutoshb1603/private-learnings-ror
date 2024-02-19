ActiveAdmin.register BxBlockCommunityforum::Question, as: 'Question' do
  
    menu label: 'Forum Posts'
    actions :all, except: [:new, :edit]
    index do
      selectable_column
      column :title
      column :description
      column :account
      column "Total Views" do |object|
        object.views.count
      end

      actions
    end

    show do |object|
        attributes_table do
            row :title
            row :description
            row :account
            row :status
            row :anonymous
            row :offensive
            row 'Total views' do
              object.views.count
            end
            row 'Last 30 days views count' do
              object.views.where('created_at > ?', Time.now - 30.days).count
            end
              div class: 'panel' do
                h3 'Comments'
                div class: 'attributes_table' do
                  table do
                    tr class: 'table-header' do
                      th 'description'
                    end
                    object.comments.each do |comment|
                      tr do
                        td comment.description
                      end
                    end
                  end
                end
              end

              div class: 'panel Charts' do
                  start_date = params[:start_date].present? ? params[:start_date] : Time.now - 7.days  
                  end_date = params[:end_date].present? ? params[:end_date] : Time.now
                  start_date = start_date.beginning_of_day
                  end_date = end_date.end_of_day
                  h3 "Views from #{start_date.strftime("%d %B %Y")} to #{end_date.strftime("%d %B %Y")}"
                  views = object.views.where('created_at > ? and created_at < ?', start_date, end_date)
                  panel "Chart" do 
                    column_chart views.group_by_day(:created_at).count
                  end
              end
        end
    end
end
  