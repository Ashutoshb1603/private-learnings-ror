
Rails.configuration.to_prepare do
  ActiveStorage::Blob.class_eval do  
    def service_url
      url = service.send(:object_for, key).public_url rescue nil
      return url
    end
  end
end