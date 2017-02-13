require 'squib'
require 'game_icons'

plane_colors = ["R", "G", "Y", "U"]
hex_colors = ["#bf2522", "#44bf22", "#bfb422", "#2f60af"]
plane_sizes = [
    "one",
    "two",
    "two",
    "two",
    "three",
    "three",
    "three",
    "three",
    "four",
    "four",
    "four",
    "five",
    "five",
    "five",
    "six"
]

data = {
    'planes' => [],
    'hex_colors' => [],
    'plane_colors' => []
}


plane_sizes.each do |plane|
    hex_colors.each_with_index do |color, index|
        data['planes'].push("dice-six-faces-" + plane)
        data['hex_colors'].push(color)
        data['plane_colors'].push(plane_colors[index])
    end
end

Squib::Deck.new width:600, height:400, cards: data['planes'].length do
  rect

  text str: data['plane_colors'], color: data['hex_colors'], font: 'Future 100', x: 150, y: 150

  rect x:410, y: 146, width: 116, height: 116, fill_color: '#d6d4d4'

  data['planes'].each_with_index do |plane, index|
      svg data: GameIcons.get(plane).recolor(fg:data['hex_colors'][index] , bg_opacity: 0).string,
          range: index, x: 390, y: 130, width: 150, height: 150
  end

  save_pdf file:'airplanes.pdf', dir: 'cards', columns: 4, rows: 3 # save is different for github gists
end
