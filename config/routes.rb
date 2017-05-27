Rails.application.routes.draw do
  post 'apps/:app_id' => 'app_registry#register'

  delete 'apps/:app_id/:instance_id' => 'app_registry#de_register', :constraints => {
      :instance_id => /[^\/]+/
  }

  put 'apps/:app_id/:instance_id' => 'app_registry#listen_heart_beat', :constraints => {
      :instance_id => /[^\/]+/
  }

  get 'apps' => 'app_registry#find_all'

  get 'app_registry/find_by_app_id'

  get 'app_registry/find_by_instance_id'

  get 'app_registry/take_out_instance'

  get 'app_registry/put_back_instance'

  get 'app_registry/update_meta_data'

  get 'app_registry/find_by_vip'

  get 'app_registry/find_by_svip'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
