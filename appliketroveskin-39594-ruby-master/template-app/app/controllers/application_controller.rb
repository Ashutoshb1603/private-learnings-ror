class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def base_url
    Rails.env.production? ? ENV['BASE_URL'] : 'http://localhost:3000'
  end

  def get_image_url(object)
    class_name =  object.class.name.split("::").last
    case class_name
    when "EmailAccount"
      object&.profile_pic&.attached? ? base_url + Rails.application.routes.url_helpers.rails_blob_url(object.profile_pic, only_path: true) : nil
    when "AdminUser"
      object&.profile_pic&.attached? ? base_url + Rails.application.routes.url_helpers.rails_blob_url(object.profile_pic, only_path: true) : nil
    else
      object&.image&.attached? ? base_url + Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true) : nil
    end
  end

  def get_video_url(object)
    object.video.attached? ? base_url + Rails.application.routes.url_helpers.rails_blob_url(object.video, only_path: true) : nil
  end

  def get_videos_url(object)
    videos = []
    if object.videos.attached?
      videos = object.videos.map {|video| base_url + Rails.application.routes.url_helpers.rails_blob_url(video, only_path: true)}
    end
    videos
  end

  def is_freezed
    @account = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
    @account = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
    render :json => {'errors' => {"message" =>'Account is Freezed. Please Unfreeze first'}}, :status => 422 if @account.freeze_account
  end

end
