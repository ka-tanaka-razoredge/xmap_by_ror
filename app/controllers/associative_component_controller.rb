require "./app/usecases/build_tree_usecase"
require "./app/usecases/build_tree_shallowly_usecase"
class AssociativeComponentController < ApplicationController
    def index
        useCase = BuildTreeUseCase.new
        reply = useCase.execute(params[:root])
        render json: reply
#        render json: @memento
=begin        
        render json: {
            code: "okay",
            data: @memento
        }
=end
    end
    
    def index_shallowly
        useCase = BuildTreeShallowlyUseCase.new
        reply = useCase.execute(params[:root])
        render json: reply
    end
end
