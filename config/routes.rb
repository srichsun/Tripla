Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/:current_user_id/:user_id/follow', to: "users#follow", as: "follow_user"
  post '/:current_user_id/:user_id/unfollow', to: "users#unfollow", as: "unfollow_user"
end
