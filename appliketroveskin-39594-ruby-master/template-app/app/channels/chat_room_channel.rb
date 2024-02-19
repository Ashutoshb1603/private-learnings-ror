class ChatRoomChannel < ApplicationCable::Channel
    def subscribed
      stream_from "#{params[:type]}#{params[:id]}"
    end
  
    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end
  
    def speak(data)
      ActionCable.server.broadcast "#{params[:type]}#{params[:id]}", message: data["message"], sent_by: data["name"]
    end
  
  end