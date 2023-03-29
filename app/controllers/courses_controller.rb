class CoursesController < ApplicationController
  before_action :set_courses, only: %i[index]
  before_action :set_course, only: %i[show edit update destroy]

  def index
    @courses = Course.all
  end

  def show; end

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.create!(course_params)

    redirect_to courses_path
  end

  def destroy
    @course.destroy

    redirect_to courses_path
  end

  def update
    if @course.update(course_params)
      redirect_to courses_path
    else
      render :edit
    end
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :video, :pgn, :player_color)
  end

  def set_courses
    @courses = Course.all
  end

  def set_course
    @course = Course.find(params[:id])
  end
end
