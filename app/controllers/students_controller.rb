class StudentsController < ApplicationController
  before_action :set_student

  def new
    @student = Student.new
  end

  def create
    @student = Student.create(student_params)
    redirect_to '/'
  end

  private
    def student_params
      params.require(:student).permit(:name, :contact)
    end

    def set_student
      @student = params[:id] if params[:id]
    end
end
