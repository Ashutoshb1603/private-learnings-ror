module BxBlockEventregistration
    class EventBlockSerializer < BuilderBase::BaseSerializer
  
        attributes *[ :event_name,
                      :location,
                      :start_date_and_time,
                      :end_date_and_time,
                      :description, 
                      :created_at, 
                      :updated_at
                ]

        attributes :images do |object|
            if object.images.attachments
                image_urls = object.images.map do |image| 
                  image.service_url rescue nil
                end      
                image_urls
            end
        end
    
        attributes :start_date_and_time do |object|
        object.start_date_and_time.strftime("%d/%m/%Y")
        end

        attributes :end_date_and_time do |object|
        object.end_date_and_time.strftime("%d/%m/%Y")
        end

        attributes :start_time do |object|
        object.start_date_and_time.strftime("%H:%M:%S")
        end

        attributes :end_time do |object|
        object.end_date_and_time.strftime("%H:%M:%S")
        end
    end
end
