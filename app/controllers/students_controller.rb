class StudentsController < ApplicationController

  def new
    @student = Student.new
  end

  def create
    @student = Student.create(student_params)
    redirect_to '/'
  end

  private
    def student_params
      params.permit(:name, :contact)
    end
end
