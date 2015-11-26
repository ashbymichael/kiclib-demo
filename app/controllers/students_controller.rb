class StudentsController < ApplicationController
  before_action :set_student

  def show
    respond_to do |format|
      format.html
      format.json { render json: @student }
    end
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.create(student_params)
    redirect_to '/'
  end

  def edit
  end

  def update
    if @student.update_attributes(student_params)
      redirect_to '/'
    else
      render 'edit'
    end
  end

  def destroy
    @student.destroy
    redirect_to '/'
  end

  private
    def student_params
      params.require(:student).permit(:name, :contact)
    end

    def set_student
      @student = Student.find(params[:id]) if params[:id]
    end
end
