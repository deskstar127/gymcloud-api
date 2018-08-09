# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default("")
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#  is_active              :boolean
#  stripe_customer_id     :string
#  is_trialing            :boolean
#  subscription_end_at    :datetime
#  started_using_at       :date
#

class User < ActiveRecord::Base

  include SearchScopes::Pro
  include PublicActivity::Common
  include ProRootFolders
  include UserRelations

  devise \
    :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable,
    :validatable, :confirmable, :invitable,
    :async, :omniauthable, omniauth_providers: [:google_oauth2, :facebook]

  acts_as_reader

  scope :pros,
    -> { distinct.joins(:agreements_as_pro) }
  scope :clients, (lambda do
    distinct
      .joins(:agreements_as_client)
      .merge(UserAgreement.without_selftrained)
  end)
  scope :gymcloud_pros,
    -> { pros.where { (email =~ '%@gymcloud.com') } }
  scope :with_stripe,
    -> { where { stripe_customer_id.not_eq nil } }

  after_invitation_accepted :on_invitation_accepted
  after_create :activate!

  delegate :can?, :cannot?, to: :ability

  def ability
    @ability ||= ::Ability.new(self)
  end

  def display_name
    email
  end

  def pro?
    agreements_as_client.unscoped.is_me(id).any?
  end

  def become_a_pro!
    pro? || !!agreements_as_client.is_me(id).build.save!
  end

  def confirm
    result = super
    activate!
    result
  end

  def activate!
    update_attribute(:is_active, true)
  end

  def deactivate!
    update_attribute(:is_active, false)
  end

  def self.find_by_access_token(token)
    record = Doorkeeper::AccessToken.where(token: token).first
    record.present? && find(record.resource_owner_id) || nil
  end

  def self.create_from_omniauth(email)
    attributes = {
      email: email,
      password: Devise.friendly_token
    }
    create(attributes)
  end

  def email_is_fake?
    /^u\+[\w\-\_]*@gymcloud\.com$/
      .match(email)
      .present?
  end

  def live
    !email_is_fake?
  end

  def active_for_authentication?
    super && is_active?
  end

  def payment_required?
    ended = subscription_end_at && subscription_end_at < DateTime.now
    pro? && (!confirmed? || ended)
  end

  def lonely_client?
    !waiting_gymcloud_pro? && pros.count == 0
  end

  def waiting_gymcloud_pro?
    !pro? && request_pros.where(pro_provided: false).any?
  end

  # rubocop:disable PredicateName
  def has_active_pro?
    pros.where(invitation_token: nil).any?
  end

  def certification_required?
    statuses = ::Certificate.statuses
    statuses = [statuses[:verified], statuses[:unverified]]
    has_no_certificates = certificates.where(status: statuses).empty?
    started_using_at = self.started_using_at || Date.today
    pro? && has_no_certificates && started_using_at < 14.days.ago
  end

  private

  def on_invitation_accepted
    create_activity(
      action: :invitation_accepted,
      owner: self,
      recipient: invited_by
    )
  end

end
