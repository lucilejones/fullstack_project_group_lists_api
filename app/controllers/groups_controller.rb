class GroupsController < ApplicationController
    before_action :set_group, only: [:show, :update, :destroy]
    before_action :authenticate_request

    def index
        groups = Group.all
        render json: groups, status: :ok
    end

    def show
        # render json: @group, status: :ok
        render json: GroupBlueprint.render(@group, view: :long), status: :ok
    end

    def create
        # group = Group.new(group_params)
        group = @current_user.created_groups.new(group_params)
        group.members << @current_user

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

    def join
        group = Group.find(params[:group_id])

        return render json: {error: "You are already a member of this group."}, status: :unprocessable_entity if group.members.include?(@current_user)

        group.members << @current_user

        # Pusher.trigger(group.creator.id, 'notifications', {
        #     group_id: group.id,
        #     notification: "#{@current_user.username} has joined your group #{group.name}."
        # })

        head :ok
    end

    def leave
        group = Group.find(params[:group_id])

        group.members.delete(@current_user)

        # Pusher.trigger(group.creator.id, 'notifications', {
        #     group_id: group.id,
        #     notification: "#{@current_user.username} has left your group #{group.name}."
        # })
        
        head :ok
    end

    private

    def set_group
        @group = Group.find(params[:id])
    end

    def group_params
        params.permit(:name, :user_id)
    end
end
