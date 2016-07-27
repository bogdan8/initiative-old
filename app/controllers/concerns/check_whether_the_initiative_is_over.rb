module CheckWhetherTheInitiativeIsOver
  extend ActiveSupport::Concern
  included do
    before_action :if_the_initiative_is_over
  end

  private

  def if_the_initiative_is_over
    initiative_finished = Initiative.where(finished_day: DateTime.current.to_date, aasm_state: 'fundraiser')
    initiative_finished.map(&:finish_fundraising!) unless initiative_finished.nil?
  end
end
