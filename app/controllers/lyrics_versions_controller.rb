class LyricsVersionsController < ApplicationController
  before_action :set_lyrics_version, only: %i[ show edit update destroy accept ]
  before_action :set_song, only: %i[ index new ]

  # GET /lyrics_versions or /lyrics_versions.json
  def index
    @lyrics_versions = LyricsVersion.all
  end

  # GET /lyrics_versions/1 or /lyrics_versions/1.json
  def show
  end

  # GET /lyrics_versions/new
  def new
    @lyrics_version = LyricsVersion.new(
      song: @song,
      previous_version_id: @song.current_lyrics.try(:id),
      is_proposal: @song.current_lyrics.present? ? true : false,
      lyrics: @song.current_lyrics.try(:lyrics),
    )
  end

  # GET /lyrics_versions/1/edit
  def edit
  end

  # POST /lyrics_versions or /lyrics_versions.json
  def create
    @lyrics_version = LyricsVersion.new(lyrics_version_params)

    respond_to do |format|
      if @lyrics_version.save
        format.html { redirect_to @lyrics_version.song, notice: "Lyrics version was successfully created." }
        format.json { render :show, status: :created, location: @lyrics_version }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lyrics_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lyrics_versions/1 or /lyrics_versions/1.json
  def update
    respond_to do |format|
      if @lyrics_version.update(lyrics_version_params)
        format.html { redirect_to @lyrics_version.song, notice: "Lyrics version was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @lyrics_version }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lyrics_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lyrics_versions/1 or /lyrics_versions/1.json
  def destroy
    @lyrics_version.destroy!

    respond_to do |format|
      format.html { redirect_to song_path(@lyrics_version.song), notice: "Lyrics version was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def accept
    respond_to do |format|
      if @lyrics_version.update({ is_proposal: false })
        format.html { redirect_to @lyrics_version.song, notice: "Lyrics version was successfully accepted.", status: :see_other }
        format.json { render :show, status: :ok, location: @lyrics_version }
      else
        @lyrics_version.is_proposal = true
        flash["error"] = @lyrics_version.errors.first.type if @lyrics_version.errors.any?
        format.html { redirect_to diff_show_with_id_path(next_version_id: @lyrics_version.id, prev_version_id: @lyrics_version.previous_version.next_version.id, edit: true)}
        format.json { render json: @lyrics_version.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lyrics_version
      @lyrics_version ||= LyricsVersion.find(params.expect(:id))
    end

    def set_song
      @song ||= Song.find(params.expect(:song_id))
    end

    # Only allow a list of trusted parameters through.
    def lyrics_version_params
      params.expect(lyrics_version: [ :song_id, :previous_version_id, :is_proposal, :lyrics, :description ])
    end
end
