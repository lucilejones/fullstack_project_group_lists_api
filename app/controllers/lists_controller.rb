class ListsController < ApplicationController
    before_action :set_list, only: [:show, :update, :destroy]
    # before_action :authenticate_request

    def index
      lists = List.all
      render json: lists, status: :ok
    end
  
    def show
      # render json: @list, status: :ok
      render json: ListBlueprint.render(@list, view: :long), status: :ok
    end
  
    # to create a new list
    def create
      # list = List.new(list_params)
      list = @current_user.lists.new(list_params)
  
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
        render json: @list.errors, status: :unprocessable_entity
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
      params.permit(:name)
    end
  
    def set_list
      @list = List.find(params[:id])
    end
end
