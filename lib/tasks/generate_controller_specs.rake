namespace :spec do
  desc 'Generate specs for all controllers'
  task generate_controller_specs: :environment do
    Rails.application.eager_load!

    controllers = ApplicationController.descendants.reject do |controller|
      controller.name.include?('Rails')
    end

    controllers.each do |controller|
      system("rails generate rspec:controller #{controller.name.underscore}")
    end
  end
end
