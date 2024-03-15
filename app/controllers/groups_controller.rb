class GroupsController < ApplicationController
    before_action :set_group, only: [:show, :update, :destroy]
    before_action :authenticate_request

    def index
        groups = Group.all
        render json: groups, status: :ok
    end

    def show
        render json: @group, status: :ok
    end

    def create
        group = Group.new(group_params)

        if group.save
            render json: group, status: :created
        else
            render json: group.errors, status: :unprocessable_entity
        end
    end

    def update
        if @group.update(group_params)
            render json: @group, status: :ok
        else
            render json: @group.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @group.destroy
            render json: nil, status: :ok
        else
            render json: @group.errors, status: :unprocessable_entity
        end
    end

    private

    def set_group
        @group = Group.find(params[:id])
    end

    def group_params
        params.permit(:name, :user_id)
    end
end
