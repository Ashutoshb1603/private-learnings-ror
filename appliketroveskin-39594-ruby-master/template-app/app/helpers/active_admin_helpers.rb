module ActiveAdminHelpers
  # make this method public (compulsory)
  def self.included(dsl)
    # nothing ...
  end

  # define helper methods here ...
  def ireland_shopify(endpoint)
    url = "https://#{ENV['SHOPIFY_HOSTNAME']}.myshopify.com" + endpoint
    request_params = Hash.new
    request_params["Content-Type"] = "application/json"
    request_params["X-Shopify-Access-Token"] = ENV['SHOPIFY_ACCESS_TOKEN']
    url = URI(url)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    if request_params.present?
      request_params.each do |key, value|
        request[key] = value
      end
    end
    response = https.request(request)
    link = response["link"]
    response_json = JSON.parse(response.read_body)
    response_json["prev"] = link.present? && link.include?("prev") ? link.split("page_info").second.split(">\;").first[1..-1] : ""
    response_json["next"] = link.present? && link.include?("next") ? link.split("page_info").last.split(">\;").first[1..-1] : ""
    JSON.generate(response_json)
  end

  def uk_shopify(endpoint)
    url = "https://#{ENV['SHOPIFY_HOSTNAME_UK']}.myshopify.com" + endpoint
    request_params = Hash.new
    request_params["Content-Type"] = "application/json"
    request_params["X-Shopify-Access-Token"] = ENV['SHOPIFY_ACCESS_TOKEN_UK']
    url = URI(url)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    if request_params.present?
      request_params.each do |key, value|
        request[key] = value
      end
    end
    response = https.request(request)
    link = response["link"]
    response_json = JSON.parse(response.read_body)
    response_json["prev"] = link.present? && link.include?("prev") ? link.split("page_info").second.split(">\;").first[1..-1] : ""
    response_json["next"] = link.present? && link.include?("next") ? link.split("page_info").last.split(">\;").first[1..-1] : ""
    JSON.generate(response_json)
  end

  def get_last_post
  end
end
