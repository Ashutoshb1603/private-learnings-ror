ActiveAdmin.register_page "Appointments" do
  require "uri"
  require "net/http"

  menu label: "Consultations"

  content do
    url = params[:calendar_id].present? ?  "https://acuityscheduling.com/api/v1/appointments?calendarID=" + params[:calendar_id] : "https://acuityscheduling.com/api/v1/appointments"
    request_params = Hash.new
    request_params["Content-Type"] = "application/json"
    request_params["Authorization"] = ENV["ACUITY_AUTH_KEY"]
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
    appointments = JSON.parse(response.read_body)

    ## Filter Appointments by period
    if params[:start_date] && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      appointments = appointments.select{|a| date = Date.parse(a["date"]); date >= start_date && date <= end_date}
    end

    ## Listing all therapists
    therapiast_url = "https://acuityscheduling.com/api/v1/calendars"
    url = URI(therapiast_url)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    if request_params.present?
      request_params.each do |key, value|
        request[key] = value
      end
    end
    response = https.request(request)
    therapists = JSON.parse(response.read_body)

    div class: 'sidebar' do
      div class: 'sidebar_section panel', id: 'filters_sidebar_section' do
        h3 "Filters"
        div class: 'mb-3 d-flex align-items-end filterBlock' do
          div class: 'therapist_div' do
            label "Therapists"
           select id: 'filter_by_therapist', collection: therapists.map{|a| [a["name"], a["id"]]}, propmt: 'Select therapist'
          end
          div do
            label "Start date", class: 'date_label'
            input type: :date, id: 'start_date'
          end
          div do
            label "End date", class: 'date_label'
            input type: :date, id: 'end_date'
          end
          div do
            link_to "Filter", admin_appointments_path, class: 'link', id: "filter_appointments"
          end
        end
      end
    end

    div class: 'paginated_collection' do
      div class: 'paginated_collection_contents' do
        div class: 'index_content' do
          div class: 'index_as_table appointment_table' do
            table class: "index_table index" do
              tr do
                th "First Name", class: 'col'
                th "Last Name", class: 'col'
                th "Appointment Date & time", class: 'col'
                th "Type", class: 'col'
                th "Therapist Id", class: 'col'
                th "Therapist", class: 'col'
                th "Paid", class: 'col'
              end
              if appointments.present?
                appointments.each do |appointment|
                  tr do
                    td appointment["firstName"], class: 'col'
                    td appointment["lastName"], class: 'col'
                    td appointment["date"] + " " + appointment["time"] + " To " + appointment["endTime"], class: 'col'
                    td appointment["type"], class: 'col'
                    td appointment["calendarID"], class: 'col'
                    td appointment["calendar"], class: 'col'
                    td class: 'col' do
                      status_tag(appointment['paid'])
                    end
                  end
                end
              else
                tr do
                  td colspan: '8' do
                    h2 "No Appointments found", class: 'center-text'
                  end
                end
              end
            end
          end
        end
      end      
    end
  end
end