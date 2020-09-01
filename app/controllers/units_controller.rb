class UnitsController < ApplicationController

    def create
        @unit = Unit.new(units_params)
        if @unit.save
            flash[:success] = "Unit created!"
            redirect_to "/units"
        else
            render 'static_pages/home'
        end

    end
    def destroy
        Unit.find(params[:id]).destroy
        flash[:success] = "Unit deleted"
        redirect_to '/units'
        

    end
    # def edit
    #     Unit.find(params[:id]).update(:location => "user")
        
    # end
    def update
        # #@unit = Unit.find(params[:id])
        # if Unit.update(params[:unit])
        #     flash[:success] = "Unit Location changed"
        #     redirect_to current_user
        # end
        
    end
    def checkout
        Unit.find(params[:id]).update(:location => current_user.name)
        flash[:success] = "Unit checked out"
        redirect_to '/checkout'
        
    end
    def returning
        Unit.find(params[:id]).update(:location => "storage")
        flash[:success] = "Unit return"
        redirect_to '/returns'
        
    end
    
    private
        def units_params
            params.require(:unit).permit(:name_id, :vsu_id, :product_type_id, :condition, :location)
        end
end