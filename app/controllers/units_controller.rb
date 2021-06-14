class UnitsController < ApplicationController
    def ensure_admin!
        unless current_user and current_user.admin?
            redirect_to root_url
            flash[:danger] = "You do not have proper authorization"
        end
    end
    def index
        @units = Unit.paginate(page: params[:page])
        ensure_admin!
    end
    def request_checkout
        @units = Unit.paginate(page: params[:page])
        ensure_admin!
    end
    def request_return
        @units = Unit.paginate(page: params[:page])
        ensure_admin!
    end
    def borrowed_units
        @units = Unit.paginate(page: params[:page])
        ensure_admin!
    end
    
    def ensure_user!
        unless current_user
            redirect_to root_url
            flash[:danger] = "You are not logged in"
        end
    end
    def borrowed_list_return
        @units = Unit.paginate(page: params[:page])
        ensure_user!
    end
    def create
        @unit = Unit.new(units_params)
        if @unit.save
            flash[:success] = "Unit created!"
            redirect_to "/units"
        else
            flash[:danger] = "Error: Unit was not created"
            redirect_to "/units"
        end

    end
    def destroy
        Unit.find(params[:id]).destroy
        flash[:success] = "Unit deleted"
        redirect_to '/units'
        

    end
    def edit
        @unit = Unit.find(params[:id])
        
    end
    def update
        @unit = Unit.find(params[:id])
        if @unit.update_attributes(units_params)
            flash[:success] = "Unit Updated"
            redirect_back(fallback_location:"/")
        else
            flash[:danger] = "Error Occured"
        end
        
    end
    def checkoutA
        Unit.find(params[:id]).update(:location => current_user.name)
        flash[:success] = "User has been selected for checkout"
        redirect_to '/checkout'
        
    end
    def checkout
        Unit.find(params[:id]).update(:requestor => current_user.name)
        flash[:success] = "Unit checkout Request sent to Admins, Please wait for Approval"
        redirect_to '/checkout'
        
    end
    def approve
        Unit.find(params[:id]).update(:location => Unit.find(params[:id]).requestor)
        Unit.find(params[:id]).update(:requestor => "N/A")
        
        flash[:success] = "Request Approved"
        redirect_to '/request_checkout'
    end
    def reject
        Unit.find(params[:id]).update(:requestor => "N/A")
        Unit.find(params[:id]).update(:location => "storage")
        flash[:success] = "Request Rejected"
        redirect_to '/request_checkout'
    end
    def returning
        Unit.find(params[:id]).update(:returner => current_user.name)
        flash[:success] = "Unit return request sent to Admins, please wait for approval"
        redirect_to '/returns'
        
    end
    def rejectR
        #Unit.find(params[:id]).update(:location => Unit.find(params[:id]).requestor)
        Unit.find(params[:id]).update(:returner => "N/A")
        
        flash[:success] = "Return Request rejected"
        redirect_to '/request_return'
    end
    def approveR
        Unit.find(params[:id]).update(:returner => "N/A")
        Unit.find(params[:id]).update(:location => "storage")
        flash[:success] = "Return Request approved"
        redirect_to '/request_return'
        
    end
    def returnManually
        Unit.find(params[:id]).update(:returner => "N/A")
        Unit.find(params[:id]).update(:location => "storage")
        flash[:success] = "Unit manually returned"
        redirect_to '/borrowed_units'
    end
    
    private
        def units_params
            params.require(:unit).permit(:name_id, :vsu_id, :product_type_id, :condition, :location)
        end
end