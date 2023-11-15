require_relative 'app'
require_relative 'menu'

app = App.new
app.load_from_files

Menu.new(app)

def create_person(app)
  puts 'Create a Person'
  puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
  person_type = gets.chomp.to_i

  case person_type
  when 1
    create_student(app)
  when 2
    create_teacher(app)
  else
    puts 'Invalid person type'
  end
end

def create_student(app)
  puts 'Create a Student'
  puts 'Age:'
  age = gets.chomp.to_i
  puts 'Name:'
  name = gets.chomp
  puts 'Has parent permission? [Y/N]:'
  parent_permission = gets.chomp.downcase == 'y'
  app.create_student(name, age, parent_permission)
end

def create_teacher(app)
  puts 'Create a Teacher'
  puts 'Age:'
  age = gets.chomp.to_i
  puts 'Name:'
  name = gets.chomp
  puts 'Specialization:'
  specialization = gets.chomp
  app.create_teacher(name, age, specialization)
end

def create_book(app)
  puts 'Create a Book'
  puts 'Title:'
  title = gets.chomp
  puts 'Author:'
  author = gets.chomp
  app.create_book(title, author)
end

def create_rental(app)
  puts 'Create a Rental'
  puts 'Enter rental date (YYYY-MM-DD):'
  date = gets.chomp
  puts 'Select a book from the following list by number:'
  app.display_books
  book_number = gets.chomp.to_i
  puts 'Select a person from the following list by number:'
  app.display_people
  person_number = gets.chomp.to_i
  app.create_rental(date, book_number, person_number)
end

def list_rentals_for_person(app)
  puts 'List all rentals for a given person id'
  puts 'Select a person from the following list by number:'
  app.display_people
  person_number = gets.chomp.to_i
  person = app.instance_variable_get(:@people)[person_number]
  app.list_rentals_for_person(person)
end

def display_menu
  puts 'Welcome to the School Library App'
  puts 'Please choose an option by entering a number:'
  puts '1. List all books'
  puts '2. List all people'
  puts '3. Create a person'
  puts '4. Create a book'
  puts '5. Create a rental'
  puts '6. List all rentals for a given person id'
  puts '7. Exit'
end

# Solucion al error de cyclomatic complexity

def execute_option(option, app)
  case option
  when 1
    list_all_books(app)
  when 2
    list_all_people(app)
  when 3
    create_person(app)
  when 4
    create_book(app)
  when 5
    create_rental(app)
  when 6
    list_rentals_for_person(app)
  when 7
    exit_app(app)
  else
    puts 'Invalid option. Please choose a valid option.'
  end
end

def list_all_books(app)
  app.list_books
end

def list_all_people(app)
  app.list_people
end

# ...

def exit_app(app)
  app.exit_app
end

loop do
  display_menu
  option = gets.chomp.to_i
  execute_option(option, app)
  puts "\n"
end
