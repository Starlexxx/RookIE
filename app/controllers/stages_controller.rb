# frozen_string_literal: true

class StagesController < ApplicationController
  before_action :set_stage, only: %i[show edit update destroy]
  before_action :set_chapter, only: %i[new create edit]
  before_action :set_games, only: %i[new create edit]

  def index; end

  def show; end

  def new
    @stage = @chapter.stages.new(stage_params)
  end

  def create
    @stage = @chapter.stages.new(stage_params)
    if @stage.save
      redirect_to stage_path(@stage), notice: 'Stage was created successfully'
    else
      render :new
    end
  end

  def destroy
    @stage.destroy

    redirect_to @stage.chapter
  end

  def edit
    @stage.assign_attributes(stage_params)
  end

  def update
    if @stage.update(stage_params)
      redirect_to stage_path(@stage), notice: 'Stage was updated successfully'
    else
      render :edit
    end
  end

  private

  def stage_params
    params.fetch(:stage, {}).permit(:title, :stage_type, :video, :game_number)
  end

  def set_stage
    @stage = Stage.find(params[:id])
  end

  def set_chapter
    @chapter = @stage&.chapter || Chapter.find(params[:chapter_id])
  end

  def set_games
    games = @chapter.course.game_set.games
    titles = games.map { |game| game.tags['Opening'] }

    @games = Hash[titles.zip(0..titles.count)]
  end
end
