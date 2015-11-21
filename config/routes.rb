Rails.application.routes.draw do

  # just putting this inside api because it should be only accessible by json, also save some time rewriting "format : json " :)
  namespace :api, constraints: { format: 'json' } do

    ####meta resources

    #post to /tags
    resources :tags, only: [:create], :path => "tag"

    get '/stats/', to: 'stats#show_all'

    #want to be able to drop this into basically any resource we create, ever with minimal configuration
    concern :taggable_entity do
      resources :tags, only: :index do
        #need custom route here to be able to delete all tags for a given entity
        collection do
          delete :destroy_all
        end
      end

      resources :stats, only: :index #show all stats for given entity
    end
    ####

    resources :products, only: [ :show, :destroy ] do
      concerns :taggable_entity
    end

  end
end
