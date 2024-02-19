ActiveAdmin.register_page "Users Onboarding" do
    menu label: "Invite User"

    content do
        render partial: 'form'
    end

end