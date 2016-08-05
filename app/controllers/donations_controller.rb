class DonationsController < ApplicationController
  before_action :find_initiative, :stripe
  before_action :create_customer_and_charge, :stripe
  before_action :create_donate, :stripe

  def stripe
    flash[:success] = 'Ви успішно оплатили'
    redirect_to "/initiatives/#{@initiative_id}"

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to "/initiatives/#{@initiative_id}"
  end

  private

  def find_initiative
    @initiative = Initiative.find(params[:initiative_id])
  end

  def create_customer_and_charge
    @customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )
    Stripe::Charge.create(
      customer: @customer.id,
      amount: params[:amount].to_i * 100,
      description: "for initiatives: #{@initiative.title}",
      currency: params[:currency]
    )
  end

  def create_donate
    Donation.create(
      payer_id: @customer.id,
      user_id: current_user.id,
      initiative_id: @initiative.id,
      amount: params[:amount].to_i * 100,
      description: "for initiatives: #{@initiative.title}",
      currency: params[:currency]
    )
    @collected_amount = @initiative.collected_amount + params[:amount].to_i

    @initiative.update(collected_amount: @collected_amount)
  end
end
