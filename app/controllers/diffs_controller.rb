class DiffsController < ApplicationController
  def show
    raise ActionController::ParameterMissing.new(:text) unless text.present?
    raise ActionController::ParameterMissing.new(:prev_version_id) unless prev_version.present?
    next_version.errors.add(:base, flash["error"]) unless flash["error"].nil?

    respond_to do |format|
      format.html {
        render locals: {
          text: text,
          prev_version: prev_version,
          next_version: next_version,
          diff: diff,
          edit: edit?
        }
      }
      format.json {
        render json: { diff: diff.to_s(:text) }, status: :ok
      }
    end
  end

  def resolve
    params.expect(:text, :next_version_id)

    unless next_version.is_proposal
      flash["error"] = "this version is already accepted"
      return redirect_to diffs_show_path(text: text, next_version_id: next_version.id, prev_version_id: prev_version.try(:id)), status: :see_other
    end

    if next_version.conflict.present?
      conflict = next_version.conflict
      next_version.update({ previous_version: conflict, lyrics: text })
      flash["error"] = "there is a new conflict, please try again"
      return redirect_to diffs_show_path(text: text, next_version_id: next_version.id, prev_version_id: conflict.id), status: :see_other
    end

    if next_version.errors.any?
      flash["error"] = next_version.errors.full_messages.join(", ")
      return redirect_to diffs_show_path(text: text, next_version_id: next_version.id, prev_version_id: prev_version.try(:id)), status: :see_other
    end

    redirect_to next_version, status: :ok if next_version.update({ previous_version: prev_version, lyrics: text })
  end

  private
    def invalid_next_version_id!
      raise "invalid next_version_id!"
    end

    def invalid_prev_version_id!
      raise "invalid prev_version_id!"
    end

    def edit?
      @is_edit ||= params.has_key?(:edit)
    end

    def diff
      @diff ||= Diffy::Diff.new(prev_version.try(:lyrics) + "\n", text + "\n", include_diff_info: true)
    end

    def text
      @text ||= begin
                  text = params.fetch(:text, nil)
                  return text unless text.nil?
                  return nil unless next_version.present?

                  next_version.lyrics
                end
    end

    def next_version
      @next_version ||= begin
                          next_version_id = params.fetch(:next_version_id, nil)
                          return if next_version_id.nil?

                          next_version = LyricsVersion.find(next_version_id)
                          invalid_next_version_id! if next_version.nil?
                          next_version
                        end
    end

    def prev_version
      @prev_version ||= begin
                          prev_version_id = params.fetch(:prev_version_id, nil)

                          if prev_version_id.present?
                            prev_version = LyricsVersion.find(prev_version_id) unless prev_version_id.nil?
                            invalid_prev_version_id! if prev_version.nil?
                            return prev_version
                          end

                          return nil unless next_version.present?
                          next_version.previous_version
                        end
    end
end
