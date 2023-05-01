class CoursesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_courses, only: %i[index]
  before_action :set_course, only: %i[show edit update destroy]
  before_action :validate_user, only: %i[edit update destroy]

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

  def validate_user
    return :unauthorized if @course.user_id != current_user.id || !current_user.moderator?
  end

  def course_params
    params.require(:course).permit(:title, :description, :video, :thumbnail, :pgn, :player_color)
  end

  def set_courses
    @courses = Course.all
  end

  def set_course
    @course = Course.find(params[:id])
  end
end
