ActiveAdmin.register BxBlockCfrdcenroutechargesapi::EnrouteCharge, as: 'EnrouteCharge' do
  actions :index, :show
  config.per_page = 10

  # index do
  #   selectable_column
  #   id_column
  # end
end