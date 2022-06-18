class ComponentController < ApplicationController
    def index
        # TODO: Use usecases.
        @memento = Component.all
        @collection = []
        @memento.each do |value|
            bullet = {"id" => value.id, "caption" => value.caption}
            bullet["thumbnails"] = ComponentAndThumbnail.where(component: value.id).select("id, serial_number, thumbnail as uri")
            @collection << bullet
        end
        render json: @collection
    end
    
    def show
        # TODO: Use usecases.
        memento = Component.find(params[:id])
        
        children = []
        raw_children = ComponentAndComponent.where(parent: memento.id).select("child as id")
        raw_children.each do |child|
            c = { id: child.id, caption: Component.find(child.id).caption, thumbnails: ComponentAndThumbnail.where(component: child.id).select("id, thumbnail, serial_number") }
            children.push(c)
        end

        reply = {
            id: memento.id,
            caption: memento.caption,
            thumbnails: ComponentAndThumbnail.where(component: memento.id).select("id, thumbnail, serial_number"),
            children: children
        }
        render json: reply
    end

    def index_for_containers
        # TODO: Use usecases.
        @memento = ComponentAndComponent.select("DISTINCT parent as id").order("id")
        @collection = []
        @memento.each do |value|
            if (ComponentAndComponent.where(child: value.id).length === 0)
                raw = Component.find(value.id)
                container = {
                    id: raw.id,
                    caption: raw.caption,
                    what: raw.what,
                    logo: nil
                }
                if raw.logo?
                    container["logo"] = "http://192.168.10.110/thumbnails_for_xmap/" + raw.logo
                end
                @collection.push(container)
            end
        end
        render json: {
            code: "okay",
            data: @collection
        }
    end
end
