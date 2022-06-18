class Component < ApplicationRecord
  self.table_name = 'component'
  self.primary_key = 'id'
  has_many :component, class_name: "Component", through: :component_and_component, class_name: "ComponentAndComponent", foreign_key: "id"
  has_many :thumbnails, class_name: "ComponentAndThumbnail", foreign_key: "id"
end
