class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :update, :destroy]
    before_action :authenticate_request

    def index
        items = Item.all
        render json: items, status: :ok
    end

    def show
        render json: @item, status: :ok
    end

    def create
        item = Item.new(item_params)

        if item.save
            render json: item, status: :created
        else
            render json: item.errors, status: :unprocessable_entity
        end
    end

    def update
        if @item.update(item_params)
            render json: @item, status: :ok
        else
            render json: @item.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if@item.destroy
            render json: nil, status: :ok
        else
            render json: @item.errors, status: :unprocessable_entity
        end
    end

    private

    def set_item
        @item = Item.find(params[:id])
    end

    def item_params
        params.permit(:name, :brand, :store, :notes, :need_to_purchase, :list_id)
    end
end
