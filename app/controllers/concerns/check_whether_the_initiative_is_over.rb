module CheckWhetherTheInitiativeIsOver
  extend ActiveSupport::Concern
  included do
    before_action :if_the_initiative_is_over
    before_action :if_the_initiative_begin_implemented
  end

  private

  def if_the_initiative_is_over
    initiative_finished = Initiative.where(finished_day: DateTime.current.to_date, aasm_state: 'fundraiser')
    initiative_finished.map(&:finish_fundraising!) unless initiative_finished.nil?
  end

  def if_the_initiative_begin_implemented
    initiative_finished = Initiative.where(finished_day: DateTime.current.to_date, aasm_state: 'being_implemented')
    initiative_finished.map(&:check_implemented!) unless initiative_finished.nil?
  end
end
