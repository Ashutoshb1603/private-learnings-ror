ActiveAdmin.register BxBlockCatalogue::Aircraft, as: "Aircraft Data Master" do
  actions :index, :show
  active_admin_import


  action_item only: [:import] do
    link_to('Download Sample File',download_admin_aircraft_data_masters_path())
  end

  collection_action :download, method: :get do
    file_name = Rails.root + "lib/Private_Bombardier.xlsx"
    send_file file_name, type: "application/csv"
  end

  index :download_links => false do
    selectable_column
    id_column
    column :tail_number
    column :aircraft_base_country
    column :aircraft_base_iata
    column :aircraft_base_icao
    column :aircraft_serial_number
    column :aircraft_country_of_registration
    column :make
    column :model
    column :category
    column :year_of_manufacture
    column :year_of_exterior_refurbishment
    column :year_of_interior_refurbishment
    column :number_of_seats
    column :luggage_volume
    column :entertainment
    column :interior_accessories
    actions
  end

  show do
  	attributes_table do
  		row :tail_number
  		row :aircraft_base_country
  		row :aircraft_base_iata
  		row :aircraft_base_icao
  		row :aircraft_serial_number
  		row :aircraft_country_of_registration
  		row :make
  		row :model
  		row :category
  		row :year_of_manufacture
  		row :year_of_exterior_refurbishment
  		row :year_of_interior_refurbishment
  		row :number_of_seats
  		row :luggage_volume
  		row :entertainment
  		row :interior_accessories
  		panel 'Aircraft Company' do
  		  if resource.aircraft_companies.present?
  		    table_for resource.aircraft_companies do
  		    	column :company_name
  		    	column :company_location
  		    	column :company_address
  		    	column :company_city
  		    	column :company_state
  		    	column :company_zipcode
  		    	column :company_web_address
  		    	column :company_phone
  		    	column :company_fax
  		    end
  		  else
  		  	"Not Available"
  		  end
  		end  		
  	end
  end

  controller do
    def scoped_collection
      BxBlockCatalogue::Aircraft.where(is_file_imported: true)
    end

    def do_import
      if params[:active_admin_import_model] && params[:active_admin_import_model][:file]
      	file = params[:active_admin_import_model][:file]
      	file_path = params[:active_admin_import_model][:file].path
      	if params[:active_admin_import_model][:file].content_type.include?("csv")
          csv = Roo::CSV.new(file_path)
      	elsif [".xls", ".xlsx"].include? File.extname(file.original_filename)
      		xlsx_file = Roo::Spreadsheet.open(file_path)
      		columns = xlsx_file.sheet(0).row(1)
      		if columns[0] == "Company Name" && columns[1] == "Company Location" && columns[2] == "Company Address" && columns[3] == "Company City" && columns[4] == "Company State" && columns[5] == "Company Zip Code" && columns[6] == "Company Web Address" && columns[7] == "Company Phone" && columns[8] == "Company Fax" && columns[9] == "Aircraft Registration Number" && columns[10] == "Aircraft Base Country" && columns[11] == "Aircraft Base (IATA)" && columns[12] == "Aircraft Base (ICAO)" && columns[13] == "Aircraft Serial Number" && columns[14] == "Aircraft Country of Registration" && columns[15] == "MAKE" && columns[16] == "MODEL" && columns[17] == "Aircraft Category" && columns[18] == "Year of Manufacture" && columns[19] == "Year of Exterior Refurbishment" && columns[20] == "Year of Interior Refurbishment" && columns[21] == "Passenger Capacity" && columns[22] == "Luggage Volume" && columns[23] == "Wifi" && columns[24] == "Interior Accessories" && columns[25] == "Entertainment"
	      		((xlsx_file.first_row + 1)..xlsx_file.last_row).each do |index|
	      			row_data = xlsx_file.sheet(0).row(index)
	      			category = BxBlockCategories::Category.find_or_create_by(name: row_data[17]) if row_data[17].present?
	      			aircraft = BxBlockCatalogue::Aircraft.find_or_create_by(tail_number: row_data[9])
	      			aircraft.update(year_of_manufacture: row_data[18], year_of_exterior_refurbishment: row_data[19], year_of_interior_refurbishment: row_data[20], aircraft_base_country: row_data[10], aircraft_base_iata: row_data[11], aircraft_base_icao: row_data[12], aircraft_serial_number: row_data[13], aircraft_country_of_registration: row_data[14], make: row_data[15], luggage_volume: row_data[22], interior_accessories: row_data[24], entertainment: row_data[25], model: row_data[16], number_of_seats: row_data[21], category_id: category.id, is_file_imported: true)
	      			aircraft.aircraft_companies.delete_all
	      			aircraft_company = aircraft.aircraft_companies.create(company_name: row_data[0], company_location: row_data[1], company_address: row_data[2], company_city: row_data[3], company_state: row_data[4], company_zipcode: row_data[5], company_web_address: row_data[6], company_phone: row_data[7], company_fax: row_data[8])
	      		end
	      		redirect_to admin_aircraft_data_masters_path, notice: "File uploaded successfully!"
      		else
      			redirect_to import_admin_aircraft_data_masters_path, flash: {error: "File format not valid!"}
      		end
      	else
      		redirect_to import_admin_aircraft_data_masters_path, flash: {error: "File format not valid!"}
      	end
      else
        redirect_to import_admin_aircraft_data_masters_path, flash: {error: "Please select file!"}
      end
    end
  end
end
