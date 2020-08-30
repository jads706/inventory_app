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
    
    private
        def product_types_params
            params.require(:product_type).permit(:model, :brand)
        end
end