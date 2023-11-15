require_relative 'classroom'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
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
    exit
  end
end
