class DonationsController < ApplicationController
  include PayPal::SDK::REST
  protect_from_forgery except: [:hook]
  def stripe
    @initiative = Initiative.find(params[:initiative_id])
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
    if @initiative.collected_amount >= @initiative.sum
      @initiative.finish_fundraising!
      @text = 'Ініціатива завершила збір коштів і перейшла на розгляд адміністратора'
    else
      @text = 'Ви успішно оплатили'
    end
    flash[:success] = @text
    redirect_to root_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end

  def paypal
    @initiative = Initiative.find(params[:initiative_id])
    @amount = params[:amount].to_i
    Donation.create(user_id: current_user.id, initiative_id: @initiative.id, amount: @amount)
    redirect_to @initiative.paypal_url(initiative_path(@initiative), @amount)
  end

  def hook
    params.permit!
    @donation = Donation.find_by_initiative_id params[:invoice]
    status = params[:payment_status]
    if status == 'Completed'
      @initiative.update(collected_amount: @collected_amount)
      @initiative.finish_fundraising! unless @initiative.collected_amount < @initiative.sum
      @donation.update_attributes(transaction_id: params[:txn_id], purchased_at: Time.current, aasm_state: 'completed')
    else
      flash[:alert] = 'Вашій картці було відмовлено в транзакції!'
      @donation.destroy
      redirect_to initiative_path(@initiative)
    end
    render nothing: true
  end
end
