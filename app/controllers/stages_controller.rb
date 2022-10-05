class StagesController < ApplicationController
  class StagesController < ApplicationController
    before_action :set_stages, only: %i[index]
    before_action :set_stage, only: %i[show edit update destroy]
    before_action :set_chapter, only: %i[new create]

    def index
      @stages = Stage.all
    end

    def show; end

    def new
      @stage = @chapter.chapters.new
    end

    def create
      @stage = @chapter.chapters.new(chapter_params)
      if @stage.save
        redirect_to course_chapter_path(@chapter), notice: 'Stage was created successfully'
      else
        render :new
      end

    end

    def destroy
      @stage.destroy

      redirect_to @stage.chapter
    end

    def update
      if @stage.update(chapter_params)
        redirect_to @stage
      else
        render :edit
      end
    end

    private

    def stage_params
      params.require(:stage).permit(:title, videos: [])
    end

    def set_stages
      @stages = Stage.all
    end

    def set_stage
      @stage = Stage.find(params[:id])
    end

    def set_chapter
      @chapter = Chapter.find(params[:course_id])
    end
  end
end
