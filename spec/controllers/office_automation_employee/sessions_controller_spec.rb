require 'spec_helper'

module OfficeAutomationEmployee
  describe SessionsController do
    devise_mapping
    include_engine_routes

    context "#new" do
      it "renders new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end
  end
end
