class DonationsController < ApplicationController
  before_action :find_initiative, :stripe
  before_action :create_customer_and_charge, :stripe
  before_action :create_donate, :stripe
  before_action :check_whether_enough_money, :stripe

  def stripe
    flash[:success] = @text
    redirect_to root_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
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

  def check_whether_enough_money
    if @initiative.collected_amount >= @initiative.sum
      @initiative.finish_fundraising!
      @text = 'Ініціатива завершила збір коштів і перейшла на розгляд адміністратора'
    else
      @text = 'Ви успішно оплатили'
    end
  end
end
