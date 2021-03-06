class OrdersController < ApplicationController
    before_action :set_new_order, only: [:show]

    def show
    end

    def new 
        @event = Event.find(params[:event_id])
        @ticket_types = @event.ticket_types
        @order = Order.new
    end

    def create
        @event = Event.find(params[:event_id])
        @ticket_types = @event.ticket_types
        @order = Order.new order_params
        @order.total_price_calculation
        #@order.quantity_remaining
        if @order.quantity > 10
            flash[:error] = "you cannot order more than 10 tickets at a time"
            render 'new'
        
            elsif @order.save
                redirect_to event_order_path(id: @order.id)
                flash[:success] = "Your order was created successfully"
            else
                render 'new'
        end
    end


    private

    def set_new_order
        @order = Order.find(params[:id])
    end

    def order_params
        params.require(:order).permit(:ticket_type_id, :name, :phone, :address, :quantity)
    end

end
