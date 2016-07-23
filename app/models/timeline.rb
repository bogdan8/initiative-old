class Timeline < ActiveRecord::Base
  validates :title, presence: true
end
