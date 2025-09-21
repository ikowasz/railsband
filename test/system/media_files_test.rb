require "application_system_test_case"

class MediaFilesTest < ApplicationSystemTestCase
  setup do
    @media_file = media_files(:one)
  end

  test "visiting the index" do
    visit media_files_url
    assert_selector "h1", text: "Media files"
  end

  test "should create media file" do
    visit media_files_url
    click_on "New media file"

    fill_in "File", with: @media_file.file
    fill_in "Name", with: @media_file.name
    fill_in "Song", with: @media_file.song_id
    click_on "Create Media file"

    assert_text "Media file was successfully created"
    click_on "Back"
  end

  test "should update Media file" do
    visit media_file_url(@media_file)
    click_on "Edit this media file", match: :first

    fill_in "File", with: @media_file.file
    fill_in "Name", with: @media_file.name
    fill_in "Song", with: @media_file.song_id
    click_on "Update Media file"

    assert_text "Media file was successfully updated"
    click_on "Back"
  end

  test "should destroy Media file" do
    visit media_file_url(@media_file)
    click_on "Destroy this media file", match: :first

    assert_text "Media file was successfully destroyed"
  end
end
