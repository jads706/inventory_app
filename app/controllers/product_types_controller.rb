class ProductTypesController < ApplicationController

    def index
        @product_types = ProductType.all
    end
    def create
        @product_types = ProductType.new(product_types_params)
        if @product_types.save
            flash[:success] = "Product Type created!"
            redirect_to current_user
        else
            render 'static_pages/home'
        end

    end
    def destroy
        ProductType.find(params[:id]).destroy
        flash[:success] = "Product Type deleted"
        redirect_to current_user
        

    end
    def testAdd
        ProductType.create!(typeName: "ee", modelID: "0000")
    end
    
    private
        def product_types_params
            params.require(:product_type).permit(:typeName, :modelID)
        end
end