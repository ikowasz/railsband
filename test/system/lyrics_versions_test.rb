require "application_system_test_case"

class LyricsVersionsTest < ApplicationSystemTestCase
  setup do
    @lyrics_version = lyrics_versions(:one)
  end

  test "visiting the index" do
    visit lyrics_versions_url
    assert_selector "h1", text: "Lyrics versions"
  end

  test "should create lyrics version" do
    visit lyrics_versions_url
    click_on "New lyrics version"

    check "Is proposal" if @lyrics_version.is_proposal
    fill_in "Lyrics", with: @lyrics_version.lyrics
    fill_in "Previous version", with: @lyrics_version.previous_version_id
    fill_in "Song", with: @lyrics_version.song_id
    click_on "Create Lyrics version"

    assert_text "Lyrics version was successfully created"
    click_on "Back"
  end

  test "should update Lyrics version" do
    visit lyrics_version_url(@lyrics_version)
    click_on "Edit this lyrics version", match: :first

    check "Is proposal" if @lyrics_version.is_proposal
    fill_in "Lyrics", with: @lyrics_version.lyrics
    fill_in "Previous version", with: @lyrics_version.previous_version_id
    fill_in "Song", with: @lyrics_version.song_id
    click_on "Update Lyrics version"

    assert_text "Lyrics version was successfully updated"
    click_on "Back"
  end

  test "should destroy Lyrics version" do
    visit lyrics_version_url(@lyrics_version)
    click_on "Destroy this lyrics version", match: :first

    assert_text "Lyrics version was successfully destroyed"
  end
end
