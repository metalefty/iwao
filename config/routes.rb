Rails.application.routes.draw do
  root 'guest_regs#new'

  resources :guest_regs, param: :uuid do
    member do
      get :approve
    end

    collection do
      get :sent
      get :approved
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
