class MediaFilesController < ApplicationController
  before_action :set_media_file, only: %i[ show edit update destroy ]
  before_action :set_song, only: %i[ index new ]

  # GET /media_files or /media_files.json
  def index
    @media_files = MediaFile.all
  end

  # GET /media_files/1 or /media_files/1.json
  def show
  end

  # GET /media_files/new
  def new
    @media_file = MediaFile.new(
      song: @song,
    )
  end

  # GET /media_files/1/edit
  def edit
  end

  # POST /media_files or /media_files.json
  def create
    @media_file = MediaFile.new(media_file_params)

    respond_to do |format|
      if @media_file.save
        format.html { redirect_to @media_file.song, notice: "Media file was successfully created." }
        format.json { render :show, status: :created, location: @media_file }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @media_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /media_files/1 or /media_files/1.json
  def update
    respond_to do |format|
      if @media_file.update(media_file_params)
        format.html { redirect_to @media_file.song, notice: "Media file was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @media_file }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @media_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media_files/1 or /media_files/1.json
  def destroy
    @media_file.destroy!

    respond_to do |format|
      format.html { redirect_to @media_file.song, notice: "Media file was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media_file
      @media_file = MediaFile.find(params.expect(:id))
    end

    def set_song
      @song = Song.find(params.expect(:song_id))
    end

    # Only allow a list of trusted parameters through.
    def media_file_params
      params.expect(media_file: [:song_id, :uploader, :name ])
    end
end
