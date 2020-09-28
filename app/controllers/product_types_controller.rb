class ProductTypesController < ApplicationController

    def index
        @product_type = ProductType.all
    end
    def new
        @product_type = ProductType.new
    end
    def create
        @product_type = ProductType.new(product_types_params)
        if @product_type.save
            flash[:success] = "Product Type created!"
            redirect_to '/product_types'
        else
            render 'static_pages/home'
        end

    end
    def destroy
        begin
        ProductType.find(params[:id]).destroy
        flash[:success] = "Product Type deleted"
        redirect_to '/product_types'
        rescue Exception
        flash[:danger] = "Cannot delete type since unit is using that type"
        redirect_to '/product_types'
            
        end
        

    end
    
    private
        def product_types_params
            params.require(:product_type).permit(:model, :brand)
        end
end