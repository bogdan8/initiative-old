module AbilityStateToInitiatives
  extend ActiveSupport::Concern

  def for_confirmation
    if @initiative.submit_for_confirmation!
      redirect_to '/user_panels'
      flash[:success] = t('controller.initiative.for_confirmation')
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end

  def success_confirmation
    @initiative.update_attribute('finished_day', DateTime.now.to_date + 30)
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
