class AppRegistryController < ApplicationApiController
  class_attribute :registry
  self.registry = {}

  def register
    app_id = params[:app_id]
    init_if_necessary app_id
    info = InstanceInfo.new
    info.assign_attributes instance_params(params)
    info.last_heart_beat = Time.now
    logger.tagged("#{app_id}", "#{params[:instance_id]}") {
      logger.info 'Registering'
    }
    registry[app_id][info.instance_id] = info

    render json: {
        :success => true
    }
  end

  def de_register
    logger.tagged("#{params[:app_id]}", "#{params[:instance_id]}") {
      logger.info 'De-registering'
    }
    registry[params[:app_id]].delete(params[:instance_id]) if registry.has_key? params[:app_id]

    render json: {
        :success => true
    }
  end

  def listen_heart_beat
    app_id = params[:app_id]
    instance_id = params[:instance_id]
    logger.tagged("#{app_id}", "#{instance_id}") {
      logger.info 'Heart-Beat'
    }
    registry[app_id][instance_id].last_heart_beat = Time.now if registry.has_key?(app_id) and registry[app_id].has_key?(instance_id)

    render json: {
        :success => true
    }
  end

  def find_all
    render json: registry
  end

  def find_by_app_id
    if registry.has_key?(params[:app_id])
      render json: registry[params[:app_id]]
    else
      render json: {}
    end
  end

  def find_by_instance_id
    if registry.has_key?(params[:app_id]) and registry[params[:app_id]].has_key?(params[:instance_id])
      render json: registry[params[:app_id]][params[:instance_id]]
    else
      render json: {}
    end
  end

  private
  def init_if_necessary(app_id)
    registry[app_id] = {} unless registry.has_key? app_id
  end

  def instance_params(params)
    params.permit(:instance_id, :host_name, :host_ip, :host_port, :app_base, :app_id, meta_data: params[:meta_data].keys)
  end
end
