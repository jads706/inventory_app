class UnitsController < ApplicationController

    def create
        @unit = Unit.new(units_params)
        if @unit.save
            flash[:success] = "Unit created!"
            redirect_to current_user
        else
            render 'static_pages/home'
        end

    end
    def destroy
        Unit.find(params[:id]).destroy
        flash[:success] = "Unit deleted"
        redirect_to current_user
        

    end
    
    private
        def units_params
            params.require(:unit).permit(:name_id, :vsu_id, :product_type_id, :condition, :location)
        end
end