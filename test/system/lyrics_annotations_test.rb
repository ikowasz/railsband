require "application_system_test_case"

class LyricsAnnotationsTest < ApplicationSystemTestCase
  setup do
    @lyrics_annotation = lyrics_annotations(:one)
  end

  test "visiting the index" do
    visit lyrics_annotations_url
    assert_selector "h1", text: "Lyrics annotations"
  end

  test "should create lyrics annotation" do
    visit lyrics_annotations_url
    click_on "New lyrics annotation"

    fill_in "Comment", with: @lyrics_annotation.comment_id
    fill_in "Line length", with: @lyrics_annotation.line_length
    fill_in "Line start", with: @lyrics_annotation.line_start
    fill_in "Lyrics version", with: @lyrics_annotation.lyrics_version_id
    fill_in "Media file", with: @lyrics_annotation.media_file_id
    click_on "Create Lyrics annotation"

    assert_text "Lyrics annotation was successfully created"
    click_on "Back"
  end

  test "should update Lyrics annotation" do
    visit lyrics_annotation_url(@lyrics_annotation)
    click_on "Edit this lyrics annotation", match: :first

    fill_in "Comment", with: @lyrics_annotation.comment_id
    fill_in "Line length", with: @lyrics_annotation.line_length
    fill_in "Line start", with: @lyrics_annotation.line_start
    fill_in "Lyrics version", with: @lyrics_annotation.lyrics_version_id
    fill_in "Media file", with: @lyrics_annotation.media_file_id
    click_on "Update Lyrics annotation"

    assert_text "Lyrics annotation was successfully updated"
    click_on "Back"
  end

  test "should destroy Lyrics annotation" do
    visit lyrics_annotation_url(@lyrics_annotation)
    click_on "Destroy this lyrics annotation", match: :first

    assert_text "Lyrics annotation was successfully destroyed"
  end
end
