class InstanceInfo
  include ActiveRecord::AttributeAssignment
  attr_accessor :app_id, :instance_id, :host_name, :host_ip, :host_port, :app_base, :meta_data, :last_heart_beat
end