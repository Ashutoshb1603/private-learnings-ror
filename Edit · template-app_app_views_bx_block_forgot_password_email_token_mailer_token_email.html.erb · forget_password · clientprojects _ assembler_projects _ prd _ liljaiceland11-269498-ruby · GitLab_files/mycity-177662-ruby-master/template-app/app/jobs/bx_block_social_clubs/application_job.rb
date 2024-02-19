module BxBlockSocialClubs
  class ApplicationJob < BuilderBase::ApplicationJob
    def client_conversation(client, unique_name, friendly_name, current_user)
			begin
      	client.conversations.conversations.create(unique_name: unique_name, friendly_name: friendly_name, attributes: {first_name: current_user.first_name, last_name: current_user.last_name, email: current_user.email}.to_json)
			rescue
				return nil
			end
    end 

    def create_identity(account)
      "#{account.first_name}-#{account.last_name}-#{account.id}"
    end

		def create_participants(client, conversation_sid, account)
			begin
				client.conversations
							.conversations(conversation_sid)
							.participants
							.create(identity: create_identity(account))
			rescue
				return nil
			end
    end

		def message_push_notification(client)
      client.conversations
            .v1
            .services(ENV['SERVICE_SID'])
            .configuration
            .notifications
            .update(added_to_conversation_enabled: true, 
                    added_to_conversation_sound: 'default',
                    new_message_enabled: true,  
                    new_message_template: 'A New message from ${USER}: ${MESSAGE}',
                    new_message_sound: 'ring',
                    added_to_conversation_template: 'A New message from ${USER}: ${MESSAGE}')
    end
  end
end
