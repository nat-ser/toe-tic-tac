$: << "."

Dir["lib/models/*.rb"].each { |f| require f }
Dir["lib/services/*.rb"].each { |f| require f }
