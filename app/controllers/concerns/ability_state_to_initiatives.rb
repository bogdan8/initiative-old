module AbilityStateToInitiatives
  extend ActiveSupport::Concern

  included do
    before_action :for_confirmation
    before_action :success_confirmation
    before_action :error_confirmation
  end

  def for_confirmation
    if @initiative.submit_for_confirmation!
      redirect_to '/user_panels'
      flash[:success] = t('controller.initiative.for_confirmation')
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end

  def success_confirmation
    if @initiative.success_confirmation!
      redirect_to '/initiatives/pending_approval'
      flash[:success] = t('controller.initiative.success_confirmation')
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end

  def error_confirmation
    if @initiative.error_confirmation!
      redirect_to '/initiatives/pending_approval'
      flash[:success] = t('controller.initiative.error_confirmation')
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end
end