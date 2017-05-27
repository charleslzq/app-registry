class AppRegistryController < ApplicationApiController
  class_attribute :registry
  self.registry = {}

  def register
    app_id = params[:app_id]
    init_if_necessary app_id
    info = InstanceInfo.new
    info.assign_attributes instance_params(params)
    registry[app_id][info.instance_id] = info
  end

  def de_register
    registry[params[:app_id]].delete(params[:instance_id]) if registry.has_key? params[:app_id]
  end

  def listen_heart_beat
    registry[params[:app_id]][params[:instance_id]].last_heart_beat = Time.now if registry.has_key?(params[:app_id]) and registry[params[:app_id]].has_key?(params[:instance_id])
  end

  def find_all
    respond_to do |format|
      format.json { render json: registry }
    end
  end

  def find_by_app_id
    puts request.to_s
  end

  def find_by_instance_id
    puts request.to_s
  end

  def take_out_instance
    puts request.to_s
  end

  def put_back_instance
    puts request.to_s
  end

  def update_meta_data
    puts request.to_s
  end

  def find_by_vip
    puts request.to_s
  end

  def find_by_svip
    puts request.to_s
  end

  private
  def init_if_necessary(app_id)
    registry[app_id] = {} unless registry.has_key? app_id
  end

  def instance_params(params)
    params.permit(:instance_id, :host_name, :host_ip, :host_port, :app_base, :meta_data, :app_id)
  end
end
