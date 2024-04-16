class InvitationsController < ApplicationController
    before_action :set_invitation, only: [:show, :update, :destroy]
    before_action :authenticate_request
  
    def index
      invitations = Invitation.all
      render json: invitations, status: :ok
    end

    def show
      render json: InvitationBlueprint.render(@invitation, view: :long), status: :ok
    end

    def create
      sender = @current_user
      recipient_email = invitation_params[:email]
      recipient = User.find_by(email: recipient_email)
  
      if recipient.nil?
        render json: { error: "Recipient not found" }, status: :unprocessable_entity
        return
      end
  
      existing_invitation = Invitation.find_by(sender_id: sender.id, recipient_id: recipient.id, group_id: invitation_params[:group_id])
  
      if existing_invitation.present?
        render json: { error: "Invitation already sent" }, status: :unprocessable_entity
        return
      end
  
      invitation = Invitation.new(
        sender_id: sender.id,
        recipient_id: recipient.id,
        group_id: invitation_params[:group_id],
        accepted: false
      )

      if invitation.save
        render json: invitation, status: :created
      else
        render json: { error: "Failed to send invitation" }, status: :unprocessable_entity
      end
    end

    def update
      if @invitation.update(invitation_params)
          render json: @invitation, status: :ok
      else
          render json: @invitation.errors, status: :unprocessable_entity
      end
    end

    def destroy
      if @invitation.destroy
          render json: nil, status: :ok
      else
          render json: @invitation.errors, status: :unprocessable_entity
      end
    end

    private

    def invitation_params
      params.require(:invitation).permit(:email, :group_id, :sender_id, :accepted)
    end

    def set_invitation
      @invitation = Invitation.find(params[:id])
      # @invitation = Invitation.find(invitation_params[:id])
    end
  end
  
