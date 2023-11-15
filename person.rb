class Nameable
  def correct_name
    raise NotImplementedError, 'Subclass must implement "correct_name" method'
  end
end

class Person < Nameable
  attr_accessor :name, :age, :rentals, :id
  attr_reader :classroom

  def initialize(name = 'Unknown', age = 0, parent_permission: true)
    super()
    @id = rand(1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def correct_name
    @name
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  # Método to_h agregado
  def to_h
    {
      'id' => @id,
      'name' => @name,
      'age' => @age,
      'parent_permission' => @parent_permission
    }
  end

  private

  def of_age?
    @age >= 18
  end
end
