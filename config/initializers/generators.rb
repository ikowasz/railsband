Rails.application.config.generators do |g|
  g.orm :active_record, primary_key_type: :uuid
end

module ActiveRecord::ConnectionAdapters
  class TableDefinition
    alias :base_timestamps :timestamps

    def timestamps(**options)
      options[:default] = -> { "NOW()" }

      base_timestamps(**options)
    end
  end
end