require_relative 'person'
require_relative 'classroom'

class Student < Person
  attr_reader :classroom

  def initialize(name = 'Unknown', age = 0, parent_permission: true, classroom: nil)
    super(name, age, parent_permission: parent_permission)
    self.classroom = classroom
  end

  def classroom=(classroom)
    return if @classroom == classroom # Return early if already assigned to the same classroom

    # Remove student from the current classroom
    @classroom&.remove_student(self)

    @classroom = classroom

    return unless classroom

    classroom.add_student(self) # Add student to the new classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
