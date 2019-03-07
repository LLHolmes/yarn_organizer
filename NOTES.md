post '/pirates' do
  # binding.pry
  pirate = Pirate.new(name: params[:pirate][:name], height: params[:pirate][:height], weight: params[:pirate][:weight])
  params[:pirate][:ships].each do |ship_data|
    ship = Ship.new(ship_data)
    ship.pirate = pirates
    ship.save
  end
  binding.pry
end

*set up an if statement that if pirate.save: do what you want, as a way to make sure the pirate saves.
