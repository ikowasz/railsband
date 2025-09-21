require "test_helper"

class LyricsVersionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lyrics_version = lyrics_versions(:one)
  end

  test "should get index" do
    get lyrics_versions_url
    assert_response :success
  end

  test "should get new" do
    get new_lyrics_version_url
    assert_response :success
  end

  test "should create lyrics_version" do
    assert_difference("LyricsVersion.count") do
      post lyrics_versions_url, params: { lyrics_version: { is_proposal: @lyrics_version.is_proposal, lyrics: @lyrics_version.lyrics, previous_version_id: @lyrics_version.previous_version_id, song_id: @lyrics_version.song_id } }
    end

    assert_redirected_to lyrics_version_url(LyricsVersion.last)
  end

  test "should show lyrics_version" do
    get lyrics_version_url(@lyrics_version)
    assert_response :success
  end

  test "should get edit" do
    get edit_lyrics_version_url(@lyrics_version)
    assert_response :success
  end

  test "should update lyrics_version" do
    patch lyrics_version_url(@lyrics_version), params: { lyrics_version: { is_proposal: @lyrics_version.is_proposal, lyrics: @lyrics_version.lyrics, previous_version_id: @lyrics_version.previous_version_id, song_id: @lyrics_version.song_id } }
    assert_redirected_to lyrics_version_url(@lyrics_version)
  end

  test "should destroy lyrics_version" do
    assert_difference("LyricsVersion.count", -1) do
      delete lyrics_version_url(@lyrics_version)
    end

    assert_redirected_to lyrics_versions_url
  end
end
