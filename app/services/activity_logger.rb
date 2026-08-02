class ActivityLogger
  def self.log_activity(user:, action:, record:, description:, ip_address:) #this is a keyword argument method 
    ActivityLog.create!(
      user: user,
      action: action,
      record_type: record.class.name,
      record_id: record.id,
      description: description,
      ip_address: ip_address
    )
  end
end