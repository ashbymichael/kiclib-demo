class StudentsController < ApplicationController
  before_action :require_signin
  before_action :set_student

  def index
    @students = Student.order(id: :desc).page params[:page]
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
      redirect_to student_path(@student)
    else
      render 'edit'
    end
  end

  def destroy
    @student.destroy
    redirect_to students_path
  end

  def find_student
    cleaned_student = params[:student].gsub(/\s+/, "").downcase
    p cleaned_student
    if Student.exists?(cleaned_student)
      render json: Student.find(cleaned_student)
    elsif Student.exists?(['contact LIKE ?', "%#{cleaned_student}%"])
      render json: Student.where("contact LIKE ?",
                                 "%#{cleaned_student}%")
    elsif Student.exists?(['search_name LIKE ?', "%#{cleaned_student}%"])
      render json: Student.where("search_name LIKE ?", "%#{cleaned_student}%")
    else
      render json: { message: "Couldn't find \"#{params[:student]}\"." }
    end
  end

  def import

  end

  def upload
    Student.import(params[:file])
    flash[:success] = "Students uploaded"
    redirect_to students_url
  end

  private
    def student_params
      params.require(:student).permit(:name, :contact, :sid)
    end

    def set_student
      @student = Student.find(params[:id]) if params[:id]
    end
end
