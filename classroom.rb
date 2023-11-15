require_relative 'student'

class Classroom
  attr_accessor :label, :students

  def initialize(label)
    @label = label
    @students = []
  end

  def add_student(student)
    student.classroom = self
    students << student
  end

  # to_h method added
  def to_h
    {
      'label' => @label,
      'students' => @students.map(&:id) # Esto llamará al id en cada estudiante en el arreglo
    }
  end
end
