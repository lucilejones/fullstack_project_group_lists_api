class ListsController < ApplicationController
    before_action :set_list, only: [:update, :destroy]

  
    # to create a new list
    def create
      list = List.new(list_params)
  
      if list.save
        render json: list, status: :created
      else
        render json: list.errors, status: :unprocessable_entity
      end
    end
  
    # to update a list
    def update
      if @list.update(list_params)
        render json: @list, status: :ok
      else
        render json: @list.erros, status: :unprocessable_entity
      end
    end
  
    # to delete a list
    def destroy
      if @list.destroy
        render json: nil, status: :ok
      else
        render json: @list.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def list_params
      params.permit(:name :user_id)
    end
  
    def set_list
      @list = List.find(params[:id])
    end
end
