module Helpers
    class TimeHelper
        include ActionView::Helpers::DateHelper

        def format_time_in_ago(time)
            formated_time = time_ago_in_words(time)
            formated_time.slice! "about "
            formated_time + " ago"
        end
    end
end