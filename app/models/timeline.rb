class Timeline < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :initiative
end
