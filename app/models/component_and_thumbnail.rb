class ComponentAndThumbnail < ApplicationRecord
  self.table_name = 'component_and_thumbnail'
  belongs_to :component, class_name: "Component", foreign_key: "component"
end
