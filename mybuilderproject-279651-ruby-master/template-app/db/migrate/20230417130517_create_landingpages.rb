class CreateLandingpages < ActiveRecord::Migration[6.0]
  def change
    create_table :landingpages do |t|
    	t.text :description
      	t.timestamps
    end
  end
end
