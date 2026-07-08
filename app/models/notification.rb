class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  def self.notify(recipient:, notifiable:, title:)
    create(recipient: recipient, notifiable: notifiable, title: title, read: false)
  end
end
