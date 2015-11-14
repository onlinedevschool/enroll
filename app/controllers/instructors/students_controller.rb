class Instructors::StudentsController < Instructors::ApplicationController

  def index
    students
  end

  def destroy
    Student.find(params[:id]).update_attributes(deleted_at: DateTime.now)
    redirect_to instructors_students_path
  end

private

  def students
    @students = Student.all
  end

end
