class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @pledge = Pledge.find params[:pledge_id]
  end

  def create
    @pledge = Pledge.find params[:pledge_id]
    stripe_customer = Stripe::Customer.create(
                        description: "Customer for #{current_user.email}",
                        source:      params[:stripe_token]
                      )
    current_user.stripe_customer_token  = stripe_customer.id
    current_user.stripe_last_4          = stripe_customer.cards.first.last4
    current_user.stripe_card_type       = stripe_customer.cards.first.brand
    current_user.save

    stripe_charge = Stripe::Charge.create(
                                amount:       @pledge.amount * 100,
                                currency:     "cad",
                                customer:     current_user.stripe_customer_token,
                                description: "Pledge for #{@pledge.campaign.title}"
                              )
    @pledge.stripe_txn_id = stripe_charge.id
    @pledge.complete
    @pledge.save

    redirect_to @pledge.campaign, notice: "Thanks for making the payment"
  end
end
