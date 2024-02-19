# frozen_string_literal: true

ActiveAdmin.application.namespaces[:admin].resources.each do |resource|
  resource_name = resource.resource_name
  resource_title = resource_name.human.titleize
  has_factory = FactoryBot.factories.any? do |factory|
    factory.name.to_s == resource_name.singular
  end

  RSpec.describe resource.controller, type: :controller do
    let!(:user) { create(:admin_user) }
    let(:page) { Capybara::Node::Simple.new(response.body) }
    let!(:model) do
      create(resource_name.singular) if has_factory
    end

    render_views

    before(:each) { sign_in user }

    it 'renders the index page' do
      get :index
      expect(page).to have_content(resource_title)
      if model
        show_path = send("admin_#{resource_name.singular}_path", model)
        expect(page).to have_link(model.id, href: show_path)
      end
    end

    if has_factory
      it 'renders the show page' do
        get :show, params: { id: model.to_param }
        expect(page).to have_content("#{resource_title} Details")
        expect(page).to have_content(model.name) if model.respond_to?(:name)
      end
    end
  end
end
