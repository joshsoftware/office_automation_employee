Rails.application.routes.draw do

  mount Employee::Engine => "/employee"
end
