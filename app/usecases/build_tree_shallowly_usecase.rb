class BuildTreeShallowlyUseCase
    def execute(root)
        reply = []
        query = 'SELECT DISTINCT raw.id as parent FROM ' +
            '(SELECT cmp.id, cmp.caption FROM component cmp, component_and_component cc WHERE cmp.id = cc.parent) raw ' +
            'WHERE ' +
            'raw.id NOT IN (SELECT child FROM component_and_component)'
        parents = ActiveRecord::Base.connection.select_all(query);
#        parents = ComponentAndComponent.all
#        recorded = []
        parents.each do |parent|
#            if !recorded.include?(parent.parent) && (0 === ComponentAndComponent.where(child: parent.parent).count)
#                recorded.push(parent.parent)
                raw_component = Component.find(parent["parent"])
                component = { id: raw_component.id, caption: raw_component.caption, thumbnails: ComponentAndThumbnail.where(component: parent["parent"]).select("id, thumbnail, serial_number") }
                component["children"] = do_it(component[:id])
                reply.push(component)
#            end
        end
        return reply
    end
    
    def do_it(root)
        collection = []
        memento = ComponentAndComponent.where(parent: root)
        memento.each do |value|
            bullet = {}
            bullet["id"] = Component.find(value.child).id
            bullet["caption"] = Component.find(value.child).caption
            bullet["thumbnials"] = ComponentAndThumbnail.where(component: value.child).select("id, thumbnail, serial_number")
            raw_children = ComponentAndComponent.where(parent: value.child)
            children = []
            raw_children.each do |v2|
                child = {id: v2.child, caption: Component.find(v2.child).caption, thumbnails: ComponentAndThumbnail.where(component: v2.child).select("id, thumbnail, serial_number")}
                child["children"] = do_it(v2.id)
                children.push(child)
            end
            bullet["children"] = children
            collection << bullet
        end
        return collection
    end
end