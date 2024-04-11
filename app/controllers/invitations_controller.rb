class InvitationsController < ApplicationController
    before_action :authenticate_request
  
    def create
      sender = @current_user
#   might be able to take out [:invitation] in front of all these?
      recipient_email = params[:invitation][:recipient_email]
      recipient = User.find_by(email: recipient_email)
  
      if recipient.nil?
        render json: { error: "Recipient not found" }, status: :unprocessable_entity
        return
      end
  
      existing_invitation = Invitation.find_by(sender_id: sender.id, recipient_id: recipient.id, group_id: params[:invitation][:group_id])
  
      if existing_invitation.present?
        render json: { error: "Invitation already sent" }, status: :unprocessable_entity
        return
      end
  
      invitation = Invitation.new(
        sender: sender,
        recipient: recipient,
        group_id: params[:invitation][:group_id],
        accepted: false
      )

      accept_invitation_url = params[:invitation][:accept_invitation_url]
  
      if invitation.save
        invitation_message = "You received an invitation from #{sender.username} to join a group! Click <a href='#{accept_invitation_url}'>here</a> to accept."
      
        Pusher.trigger('invitation_channel', 'send_invitation_event', { message: invitation_message }, { recipient_id: recipient.id })
  
        render json: invitation, status: :created
      else
        render json: { error: "Failed to send invitation" }, status: :unprocessable_entity
      end
    end
  end
  
