# frozen_string_literal: true

class StagesController < ApplicationController
  before_action :set_stage, only: %i[show edit update destroy]
  before_action :set_chapter, only: %i[new create]

  def index; end

  def show; end

  def new
    @stage = @chapter.stages.new(stage_params)
  end

  def create
    @stage = @chapter.stages.new(stage_params)
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
    if @stage.update(params_chapter)
      redirect_to @stage
    else
      render :edit
    end
  end

  private

  def stage_params
    params.fetch(:stage, {}).permit(:title, :stage_type, videos: [])
  end

  def set_stage
    @stage = Stage.find(params[:id])
  end

  def set_chapter
    @chapter = Chapter.find(params[:chapter_id])
  end
end
