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
    @initiative.update_attribute('finished_day', DateTime.current.to_date + @initiative.term_fundraiser)
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

  def fundraising_finished
    @initiative_fundraising_finished = Initiative.all.fundraising_finished
  end

  def started_implement
    if @initiative.started_implement!
      @initiative.update_attribute('finished_day', DateTime.current.to_date + @initiative.term_report)
      redirect_to '/initiatives/fundraising_finished'
      flash[:success] = t('controller.initiative.started_implement_success')
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end

  def insufficient_funds
    if @initiative.insufficient_funds!
      redirect_to '/initiatives/fundraising_finished'
      flash[:success] = t('controller.initiative.insufficient_funds')
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end

  def report
    @initiative_being_implemented = Initiative.all.being_implemented
  end

  def audit_implemented
    @initiative_implemented = Initiative.all.audit_implemented
  end

  def implemented
    if @initiative.finish_fundraiser_success!
      redirect_to '/initiatives/audit_implemented'
      flash[:success] = t('controller.initiative.implemented')
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end

  def unrealized
    if @initiative.finish_fundraiser_errors!
      redirect_to '/initiatives/audit_implemented'
      flash[:success] = t('controller.initiative.unrealized')
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end

  def all
    @initiatives = Initiative.all.order(created_at: :desc).page(params[:page]).per(3)
    @last_page = @initiatives.last_page?
    @current_page = @initiatives.current_page
  end

  def locked
    if @initiative.locked_forever!
      redirect_to '/initiatives/all'
      flash[:success] = t('controller.initiative.locked')
    else
      flash[:error] = @initiative.errors.full_messages.to_sentence
    end
  end
end
