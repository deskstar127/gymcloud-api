module Services
module Stripe

class UserBootstrap < BaseService

  def run
    bootstrap
  end

  def input_params
    [:user]
  end

  private

  def bootstrap
    customer = CreateCustomer.!(user: @user)
    CreateSubscription.!(customer: customer)
    CheckUserSubscription.!(user: @user, customer: customer)
  end

end

end
end
