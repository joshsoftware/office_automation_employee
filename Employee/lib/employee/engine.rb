module Employee
  class Engine < ::Rails::Engine
    isolate_namespace Employee
  end
end
