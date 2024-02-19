
ActiveAdmin.register AccountBlock::Account, as: "Repeated Offenders" do

    menu label: 'Repeated Offenders'
    menu :parent => "User Moderation Panel", :priority => 4
    permit_params :offensive

    actions :all, :except => [:new, :destroy, :edit] do
        put :update_comment
    end

    collection_action :block_or_unblock, method: :put do
        account = AccountBlock::Account.find(params[:id])
        account.toggle!(:blocked)
        redirect_to admin_repeated_offender_path(account.id)
    end

    controller do
        def scoped_collection
          super.joins(:comments).where('comments.offensive = true').distinct
        end

        def update
            object = params[:type] == "question" ? BxBlockCommunityforum::Question.find(params[:id]) : BxBlockCommunityforum::Comment.find(params[:id])
            object.offensive = !object.offensive
            object.save!
            redirect_to admin_repeated_offender_path(object.accountable.id)
        end
    end

    
    index do
      selectable_column
      column :id
      column :name
      column :email
      column :phone_number
      column 'Offensive posts' do |object|
        object.questions.offensive.count
      end
      column 'Offensive comments' do |object|
        object.comments.offensive.count
      end
      column :blocked
      actions
    end

    show do |object|
        attributes_table do
            row :id
            row :name
            row :email
            row :phone_number
            row "Block or Unblock" do
                text = object.blocked ? "Unblock" : "Block"
                link_to "#{text}", block_or_unblock_admin_repeated_offenders_path(id: object.id), {method: :put, :class=>"button button-#{object.blocked}" }
            end

            div class: 'panel' do
                h3 'Questions'
                div class: 'attributes_table' do
                    table do
                        tr class: 'table-header' do
                            th 'Question Id'
                            th 'Title'
                            th 'Description'
                            th 'Offensive'
                        end
                        object.questions.order("created_at DESC").each do |question|
                            tr do
                                td question.id
                                td question.title
                                td question.description
                                td link_to "#{question.offensive.to_s.capitalize}", admin_repeated_offender_path(question.id, type: "question"), { method: :put, :class=>"button button-#{question.offensive}" }
                            end
                        end
                    end
                end
            end
            
            div class: 'panel' do
                h3 'Comments'
                div class: 'attributes_table' do
                    table do
                        tr class: 'table-header' do
                            th 'Comment Id'
                            th 'Description'
                            th 'Offensive'
                        end
                        object.comments.order("created_at DESC").each do |comment|
                            tr do
                                td comment.id
                                td comment.description
                                td link_to "#{comment.offensive.to_s.capitalize}", admin_repeated_offender_path(comment.id, type: "comment"), { method: :put, :class => "button button-#{comment.offensive}" }
                            end
                        end
                    end
                end
            end
        end
    end
  
  end

  
  
