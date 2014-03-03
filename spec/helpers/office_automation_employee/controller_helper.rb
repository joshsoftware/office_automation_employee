module ControllerHelper
  def devise_mapping
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user] # tell devise to map to user
    end
  end

  def include_engine_routes
    routes do
      OfficeAutomationEmployee::Engine.routes
    end
  end
end
