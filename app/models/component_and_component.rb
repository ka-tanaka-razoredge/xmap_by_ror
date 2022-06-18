class ComponentAndComponent < ApplicationRecord
  self.table_name = 'component_and_component'
  belongs_to :component, class_name: "Component", foreign_key: "parent"
  belongs_to :component, class_name: "Component", foreign_key: "child"
end
