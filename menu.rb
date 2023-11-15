class Menu
  def initialize(app)
    @app = app
  end

  def process_option(option)
    option_actions = {
      1 => :list_books,
      2 => :list_people,
      3 => :create_person,
      4 => :create_book,
      5 => :create_rental,
      6 => :list_rentals_for_person,
      7 => :exit_app
    }

    if option_actions.key?(option)
      @app.send(option_actions[option])
    else
      puts 'Invalid option'
    end
  end
end
