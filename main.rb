require_relative 'app'

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

def process_option(option, app)
  case option
  when 1 then app.list_books
  when 2 then app.list_people
  when 3 then create_person(app)
  when 4 then create_book(app)
  when 5 then create_rental(app)
  when 6 then list_rentals_for_person(app)
  when 7 then app.exit_app
  else
    handle_invalid_option
  end
end

def create_person(app)
  puts 'Create a Person'
  puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
  person_type = gets.chomp.to_i
  case person_type
  when 1 then create_student(app)
  when 2 then create_teacher(app)
  else
    puts 'Invalid person type'
  end
end

def create_student(app)
  puts 'Create a Student'
  create_person_by_type(app, Student)
end

def create_teacher(app)
  puts 'Create a Teacher'
  create_person_by_type(app, Teacher)
end

def create_person_by_type(app, type)
  puts 'Age:'
  age = gets.chomp.to_i
  puts 'Name:'
  name = gets.chomp

  options = { name: name, age: age }
  options[:parent_permission] = true if type == Student

  app.create_person(type, options)
  puts "#{type} created successfully"
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

def handle_invalid_option
  puts 'Invalid option. Please choose a valid option.'
end

app = App.new

loop do
  display_menu
  option = gets.chomp.to_i
  process_option(option, app)
  puts "\n"
end
