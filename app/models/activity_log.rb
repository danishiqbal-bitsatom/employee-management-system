class ActivityLog < ApplicationRecord
  belongs_to :user


   validates :action, :record_type, :record_id, :description, presence: true
end
