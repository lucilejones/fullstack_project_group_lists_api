class User < ApplicationRecord
    has_secure_password

    validates :username, presence: true, uniqueness: true, length: {minimum: 3, maximum: 20}
    validate :validate_username
    validates :email, presence: true, uniqueness: true, length: {minimum: 5, maximum: 255}, format: {
        with: URI::MailTo::EMAIL_REGEXP
    }
    validates :first_name, presence: true
    validates :last_name, presence: true

    has_many :lists
    has_many :created_groups, class_name: 'Group', foreign_key: 'user_id'

    has_many :group_users
    # has_many :groups, through: :group_users
    has_many :joined_groups, through: :group_users, source: :group

    has_many :sent_invitations, class_name: "Invitation", foreign_key: "sender_id"
    has_many :received_invitations, class_name: "Invitation", foreign_key: "recipient_id"

    private
    def validate_username
        unless username =~ /\A[a-zA-Z0-9_]+\Z/
            errors.add(:username, "can only contain letters, numbers, and underscores, and must include at least one letter or number")
        end
    end 
end
