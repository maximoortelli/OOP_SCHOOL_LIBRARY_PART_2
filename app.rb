require 'json'
require 'fileutils' # Added line: to create the folder
require_relative 'classroom'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  attr_accessor :books, :people, :rentals

  def initialize
    FileUtils.mkdir_p('./data') # Added line: create 'data' folder if it does not exist
    @people = []
    @books = []
    @rentals = []
    load_from_files # Added line: load data when starting the app
  end

  def list_books
    puts 'List of Books:'
    @books.each { |book| puts "#{book.title} by #{book.author}" }
  end

  def list_people
    puts 'List of People:'
    @people.each do |person|
      if person.is_a?(Teacher)
        puts "[Teacher] Name: #{person.name} ID: #{person.id}: Age: #{person.age}"
      elsif person.is_a?(Student)
        puts "[Student] Name: #{person.name} ID: #{person.id}: Age: #{person.age}"
      else
        puts "Person Name: #{person.name} ID: #{person.id}: Age: #{person.age}"
      end
    end
  end

  def create_student(name, age, parent_permission)
    student = Student.new(name, age, parent_permission: parent_permission)
    @people << student
    puts 'Student created successfully'
  end

  def create_teacher(name, age, specialization)
    teacher = Teacher.new(name, age, parent_permission: true, specialization: specialization)
    @people << teacher
    puts 'Teacher created successfully'
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books << book
    puts 'Book created successfully'
  end

  def create_rental(date, book_number, person_number)
    rental = Rental.new(date, @books[book_number], @people[person_number])
    @rentals << rental
    puts 'Rental created successfully'
  end

  def display_books
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  def display_people
    @people.each_with_index do |person, index|
      if person.is_a?(Teacher)
        puts "#{index}) [Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      elsif person.is_a?(Student)
        puts "#{index}) [Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      else
        puts "#{index}) Person Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def list_rentals_for_person(person)
    rentals = @rentals.select { |rental| rental.person == person }
    if rentals.empty?
      puts "No rentals found for #{person.name}"
    else
      puts "Rentals for #{person.name}:"
      rentals.each { |rental| puts "#{rental.book.title}, Date: #{rental.date}" }
    end
  end

  def exit_app
    puts 'Exiting the app...'
    save_to_files
    exit
  end

  # New functions added to handle JSON
  def save_to_files
    File.write('./data/books.json', JSON.dump(@books.map(&:to_h)))
    File.write('./data/people.json', JSON.dump(@people.map(&:to_h)))
    rental_data = @rentals.map(&:to_h)
    File.write('./data/rentals.json', JSON.dump(rental_data))
  end

  def load_from_files
    @books = load_data('./data/books.json') { |book| Book.new(book['title'], book['author']) }

    @people = load_data('./data/people.json') do |person|
      new_person = Person.new(person['name'], person['age'])
      new_person.id = person['id']
      new_person
    end

    @rentals = load_data('./data/rentals.json') do |rental|
      book = @books.find { |b| b.title == rental['book_title'] }
      person = @people.find { |p| p.id == rental['person_id'] }
      Rental.new(rental['date'], book, person) if book && person
    end.compact
  end

  def load_data(file_name, &block)
    return [] unless File.exist?(file_name)

    json_data = JSON.parse(File.read(file_name))
    json_data.map(&block)
  end
end
