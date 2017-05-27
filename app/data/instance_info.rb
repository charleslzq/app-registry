class InstanceInfo
  include ActiveRecord::AttributeAssignment
  class_attribute :registry
  self.registry = {}

  attr_accessor :app_id, :instance_id, :host_name, :host_ip, :host_port, :app_base, :meta_data, :last_heart_beat

  def self.register(app_id, info)
    init_if_necessary app_id
    registry[app_id][info.instance_id] = info
  end

  def self.de_register(app_id, instance_id)
    registry[app_id].delete(instance_id) if registry.has_key? app_id
  end

  def self.find_all
    registry
  end

  def self.find_by_app_id(app_id)
    if registry.has_key?(app_id)
      registry[app_id]
    else
      {}
    end
  end

  def self.find_by_instance_id(app_id, instance_id)
    if registry.has_key?(app_id) and registry[app_id].has_key?(instance_id)
      registry[app_id][instance_id]
    else
      nil
    end
  end

  private
  def self.init_if_necessary(app_id)
    registry[app_id] = {} unless registry.has_key? app_id
  end

end