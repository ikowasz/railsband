class LyricsAnnotationsController < ApplicationController
  before_action :set_lyrics_annotation, only: %i[ show edit update destroy ]
  before_action :set_lyrics_version, only: %i[ index new ]

  # GET /lyrics_annotations or /lyrics_annotations.json
  def index
    @lyrics_annotations = LyricsAnnotation.all
  end

  # GET /lyrics_annotations/1 or /lyrics_annotations/1.json
  def show
  end

  # GET /lyrics_annotations/new
  def new
    @lyrics_annotation = LyricsAnnotation.new
  end

  # GET /lyrics_annotations/1/edit
  def edit
  end

  # POST /lyrics_annotations or /lyrics_annotations.json
  def create
    @lyrics_annotation = LyricsAnnotation.new(lyrics_annotation_params)

    respond_to do |format|
      if @lyrics_annotation.save
        format.html { redirect_to @lyrics_annotation, notice: "Lyrics annotation was successfully created." }
        format.json { render :show, status: :created, location: @lyrics_annotation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lyrics_annotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lyrics_annotations/1 or /lyrics_annotations/1.json
  def update
    respond_to do |format|
      if @lyrics_annotation.update(lyrics_annotation_params)
        format.html { redirect_to @lyrics_annotation, notice: "Lyrics annotation was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @lyrics_annotation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lyrics_annotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lyrics_annotations/1 or /lyrics_annotations/1.json
  def destroy
    @lyrics_annotation.destroy!

    respond_to do |format|
      format.html { redirect_to lyrics_version_lyrics_annotations_path(@lyrics_version), notice: "Lyrics annotation was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lyrics_annotation
      @lyrics_annotation = LyricsAnnotation.find(params.expect(:id))
    end

    def set_lyrics_version
      @lyrics_version = LyricsVersion.find(params.expect(:lyrics_version_id))
  end

    # Only allow a list of trusted parameters through.
    def lyrics_annotation_params
      params.expect(lyrics_annotation: [ :lyrics_version_id, :media_file_id, :comment_id, :line_start, :line_length ])
    end
end
