module ColumnDefinitionConcern
  extend ActiveSupport::Concern

  class_methods do
    def column
      ColumnResolver.new self
    end
  end

  class ColumnResolver
    def initialize(record)
      @record = record
    end

    def [](property)
      property = property.to_s unless property.is_a? String
      reflection = @record.reflections[property]
      reflection.try :join_foreign_key || property
    end
  end
end
