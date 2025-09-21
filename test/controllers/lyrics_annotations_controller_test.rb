require "test_helper"

class LyricsAnnotationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lyrics_annotation = lyrics_annotations(:one)
  end

  test "should get index" do
    get lyrics_annotations_url
    assert_response :success
  end

  test "should get new" do
    get new_lyrics_annotation_url
    assert_response :success
  end

  test "should create lyrics_annotation" do
    assert_difference("LyricsAnnotation.count") do
      post lyrics_annotations_url, params: { lyrics_annotation: { comment_id: @lyrics_annotation.comment_id, line_length: @lyrics_annotation.line_length, line_start: @lyrics_annotation.line_start, lyrics_version_id: @lyrics_annotation.lyrics_version_id, media_file_id: @lyrics_annotation.media_file_id } }
    end

    assert_redirected_to lyrics_annotation_url(LyricsAnnotation.last)
  end

  test "should show lyrics_annotation" do
    get lyrics_annotation_url(@lyrics_annotation)
    assert_response :success
  end

  test "should get edit" do
    get edit_lyrics_annotation_url(@lyrics_annotation)
    assert_response :success
  end

  test "should update lyrics_annotation" do
    patch lyrics_annotation_url(@lyrics_annotation), params: { lyrics_annotation: { comment_id: @lyrics_annotation.comment_id, line_length: @lyrics_annotation.line_length, line_start: @lyrics_annotation.line_start, lyrics_version_id: @lyrics_annotation.lyrics_version_id, media_file_id: @lyrics_annotation.media_file_id } }
    assert_redirected_to lyrics_annotation_url(@lyrics_annotation)
  end

  test "should destroy lyrics_annotation" do
    assert_difference("LyricsAnnotation.count", -1) do
      delete lyrics_annotation_url(@lyrics_annotation)
    end

    assert_redirected_to lyrics_annotations_url
  end
end
