class StudentsController < ApplicationController
  before_action :set_student

  def index
    @students = Student.all
  end

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
    @student = Student.new(student_params)

    if @student.save
      redirect_to '/', flash: {success: "\"#{@student.name}\"
                               was successfully created."}
    else
      flash[:alert] = "Student not created."
      render 'new'
    end
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

  def find_student
    if Student.exists?(params[:student])
      render json: Student.find(params[:student])
    elsif Student.exists?(contact: params[:student])
      render json: Student.find_by(contact: params[:student])
    elsif Student.exists?(['name LIKE ?', "%#{params[:student]}%"])
      render json: Student.where("name LIKE ?", "%#{params[:student]}%")
    else
      render json: { message: "Couldn't find \"#{params[:student]}\"." }
    end
  end

  private
    def student_params
      params.require(:student).permit(:name, :contact)
    end

    def set_student
      @student = Student.find(params[:id]) if params[:id]
    end
end
