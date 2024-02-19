
ActiveAdmin.register BxBlockAdmin::EliteEligibility, as: "Elite Eligibility" do

    permit_params :interval, :time, :eligibility_on, :product_type, :value, :frequency
  
    menu label: "Elite GG - Upgrade Requirements"
    menu parent: "Elite GG - Upgrade Requirements", priority: 1

    index do
      selectable_column 
      column :time
      column :interval
      column :frequency
      column :eligibility_on  
      column :product_type
      column :value
      
      actions
    end
  
    form do |f|
      f.inputs "Elite Eligibility" do  
       f.input :interval, :input_html => {:id => "interval"}
       f.input  :time, label: "Time Period", :input_html => {:id => "time"}
       f.input :frequency, :input_html => {:id => "frequency"}
       f.input :eligibility_on, :input_html => {:id => "eligibility_on"}
       f.input :product_type, :input_html => {:id => "product_type"}
       f.input :value
      end
      actions
    end
  
  end
  
