class AddReferenceToChat < ActiveRecord::Migration[6.0]
  def change
    add_reference :chats, :social_club
  end
end
