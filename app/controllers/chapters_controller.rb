class ChaptersController < ApplicationController
  before_action :set_chapters, only: %i[index]
  before_action :set_chapter, only: %i[show edit update destroy]
  before_action :set_course, only: %i[new create]

  def index
    @chapters = Chapter.all
  end

  def show; end

  def new
    @chapter = @course.chapters.new
  end

  def create
    @chapter = @course.chapters.new(chapter_params)
    if @chapter.save
      redirect_to course_path(@course), notice: 'Chapter was created successfully'
    else
      render :new
    end

  end

  def destroy
    @chapter.destroy

    redirect_to @chapter.course
  end

  def update
    if @chapter.update(chapter_params)
      redirect_to @chapter
    else
      render :edit
    end
  end

  private

  def chapter_params
    params.require(:chapter).permit(:title, videos: [])
  end

  def set_chapters
    @chapters = Chapter.all
  end

  def set_chapter
    @chapter = Chapter.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end
end
