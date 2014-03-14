require 'spec_helper'

module OfficeAutomationEmployee

  describe UsersController do
    include_engine_routes

    context '#edit' do
      it 'Renders edit template' do
        get :edit
        expect(response).to be_success
      end
    end

  end
end
