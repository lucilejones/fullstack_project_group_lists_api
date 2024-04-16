class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_request, only: [:index, :show, :update, :destroy]

  # to get all users
  def index
    users = User.all

    render json: users, status: 200
    # render json: UserBlueprint.render(users, view: :normal), status: 200
  end

  # to get one user
  def show
    # render json: @user, status: 200
    render json: UserBlueprint.render(@user, view: :normal), status: 200
  end

  # to create a new user
  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # to update a user
  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # to delete a user
  def destroy
    if @user.destroy
      render json: nil, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def lists_index
    user = User.find(params[:user_id])
    user_lists = user.lists

    # render json: user_lists, status: :ok
    render json: ListBlueprint.render(user_lists, view: :short), status: :ok
  end

  def created_groups_index
    user = User.find(params[:user_id])
    user_groups = user.created_groups

    render json: GroupBlueprint.render(user_groups, view: :short), status: :ok
  end

  def joined_groups_index
    user = User.find(params[:user_id])
    user_groups = user.joined_groups

    render json: GroupBlueprint.render(user_groups, view: :short), status: :ok
  end

  def sent_invitations_index
    user = User.find(params[:user_id])
    user_invitations = user.sent_invitations

    render json: InvitationBlueprint.render(user_invitations, view: :long), status: :ok
  end

  def received_invitations_index
    user = User.find(params[:user_id])
    user_invitations = user.received_invitations

    render json: InvitationBlueprint.render(user_invitations, view: :long), status: :ok
  end

  private

  def user_params
    params.permit(:username, :email, :first_name, :last_name, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
