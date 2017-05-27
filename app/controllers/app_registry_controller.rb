class AppRegistryController < ApplicationApiController

  def register
    app_id = params[:app_id]
    info = InstanceInfo.new
    info.assign_attributes instance_params(params)
    info.last_heart_beat = Time.now
    logger.tagged("#{app_id}", "#{params[:instance_id]}") {
      logger.info 'Registering'
    }
    InstanceInfo.register app_id, info

    render json: {
        :success => true
    }
  end

  def de_register
    logger.tagged("#{params[:app_id]}", "#{params[:instance_id]}") {
      logger.info 'De-registering'
    }
    InstanceInfo.de_register params[:app_id], params[:instance_id]

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
    instance = InstanceInfo.find_by_instance_id app_id, instance_id
    instance.last_heart_beat = Time.now unless instance.nil?

    render json: {
        :success => true
    }
  end

  def find_all
    render json: InstanceInfo.find_all
  end

  def find_by_app_id
    render json: InstanceInfo.find_by_app_id(params[:app_id])
  end

  def find_by_instance_id
    render json: InstanceInfo.find_by_instance_id(params[:app_id], params[:instance_id])
  end

  private
  def instance_params(params)
    params.permit(:instance_id, :host_name, :host_ip, :host_port, :app_base, :app_id, meta_data: params[:meta_data].keys)
  end
end
