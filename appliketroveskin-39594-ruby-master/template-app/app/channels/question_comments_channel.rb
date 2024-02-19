class QuestionCommentsChannel < ApplicationCable::Channel

    def subscribed
        stream_from "question_comments_channel"
        QuestionCommentsChannel.all_comments(BxBlockCommunityforum::Comment.all.order(id: :desc).limit(25).reorder(id: :asc))
    end

    def unsubscribe

    end

    def send_text(data)

        ActionCable.server.broadcast('question_comments_channel', 
            message: "something"
        )
    end

    def speak(data)
        ActionCable.server.broadcast "question_comments_channel", message: data["message"], sent_by: data["name"]
    end

    def self.all_comments(messages)
        ActionCable.server.broadcast('question_comments_channel', history: messages)
    end

end