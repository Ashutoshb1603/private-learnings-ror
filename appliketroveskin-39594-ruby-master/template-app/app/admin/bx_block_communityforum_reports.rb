
ActiveAdmin.register BxBlockCommunityforum::Report, as: "Reports" do

    menu :parent => "User Moderation Panel", :priority => 5
    permit_params :offensive

    actions :all, :except => [:new, :destroy]

    scope("Posts") { |scope| scope.where(reportable_type: 'BxBlockCommunityforum::Question') }
    scope("Comment") { |scope| scope.where(reportable_type: 'BxBlockCommunityforum::Comment') }

    controller do
        def update
            object = resource.reportable
            object.update(offensive: !object.offensive)
            redirect_to admin_reports_path
        end
    end

    index do
      selectable_column
      column :id
      column "Type" do |object|
        object.reportable_type == "BxBlockCommunityforum::Question" ? "Post" : "Comment"
      end
      column :title do |object|
        object.reportable.try(:title)
      end
      column :description do |object|
        object.reportable&.description
      end
      column "Name" do |object|
        object.accountable&.name
      end
      column :created_at do |object| 
        object.created_at.strftime("%d %B %Y %H:%M")
      end
      column :offensive do |object|
        link_to "#{object.reportable.offensive.to_s.humanize}", admin_report_path(object), method: :put, class: " btn button-#{object.reportable.offensive}"
      end
    end
  
  end
  
