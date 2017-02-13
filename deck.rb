require 'squib'
require 'game_icons'

airlines = ["R", "G", "Y", "U"]
colors = ["#bf2522", "#44bf22", "#bfb422", "#2f60af"]
passengers = [1, 2, 3]
plane_sizes = [1, 2, 3, 4, 5, 6]

data = {
    'total_cards' => [],
    'plane_passengers' => [],
    'passenger_index' => [],
    'colors' => []
}

plane_index = 0
airlines.each_with_index do |airline, ind|
    passengers.each do |passenger|
        plane_sizes.each do |plane_size|
            data['total_cards'].push("#{plane_size}#{airline}")
            data['plane_passengers'].push(passenger)
            data['passenger_index'].push(plane_index)
            plane_index += 1
            data['colors'].push(colors[ind])
        end
    end
end

Squib::Deck.new cards: data['total_cards'].length do
  background color: data['colors']
  rect

  text str: data['total_cards'],
       color: 'white', font: 'Futura 300',
       x: 175, y:125, align: :center

 text str: "Passengers ->", color: 'white', font: 'Future 35', x: 100, y: 1015
 line x1:50, y1:1000, x2:775, y2: 800, stroke_color: :white, stroke_width: 10
 passengers.each do |num|
   range = data['passenger_index'].select { |i| data['plane_passengers'][i] <= num }
   svg data: GameIcons.get(:meeple).recolor(fg: '#FFFFFF', bg_opacity: 0).string, range: range,
       x: 350 + 100 * num , y: 1000, width: 80, height: 80
 end

  save format: :pdf, prefix: 'test_', dir: 'cards', columns: 3, rows: 3 # save is different for github gists

end
