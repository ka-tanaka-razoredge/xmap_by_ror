class BuildTreeUseCase
    def execute(root)
        component = Component.find(root)
        children = []
        recorded = []
        raw_children = ComponentAndComponent.where(parent: root)
        raw_children.each do |child|
#            if !recorded.include?(child.parent)
                recorded.push(child.parent)
                raw_child = Component.find(child.child)
                children.push({
                    id: raw_child.id,
                    caption: raw_child.caption,
                    children: do_it(raw_child.id)
                })
#            end
        end
        
        logo = nil;
        if component.logo?
            logo = 'http://192.168.10.7/thumbnails_for_xmap/' + component.logo 
        end
        
        reply = {
            id: component.id,
            capiton: component.caption,
            what: component.what,
            logo:  logo,
            thumbnails: ComponentAndThumbnail.where(component: component.id).select("id, thumbnail, serial_number"),
            children: children
        }
        return reply
    end
    
    def do_it(root)
        collection = []
        memento = ComponentAndComponent.where(parent: root)
        memento.each do |value|
            raw = Component.find(value.child);
            bullet = {
                id: raw.id,
                caption: raw.caption,
                what: raw.what,
                thumbnails: ComponentAndThumbnail.where(component: raw.id).select("id, thumbnail, serial_number")
            }
            
            raw_children = ComponentAndComponent.where(parent: value.child)
            children = []
            raw_children.each do |v2|
                child = {
                    id: v2.child,
                    caption: Component.find(v2.child).caption,
                    what: Component.find(v2.child).what,    
                    thumbnails: ComponentAndThumbnail.where(component: v2.id).select("id, thumbnail, serial_number")
                }
                child["children"] = do_it(v2.id)
                children.push(child)
            end
            bullet["children"] = children
            
            collection << bullet
        end
        return collection
    end
end