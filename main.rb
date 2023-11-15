require_relative 'app'
require_relative 'menu'

app = App.new
option_processor = Menu.new(app)
loop do
  app.display_menu
  option = gets.chomp.to_i
  option_processor.process_option(option)
  puts "\n"
end
