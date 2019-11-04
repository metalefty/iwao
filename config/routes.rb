Rails.application.routes.draw do
  root 'guest_regs#new'

  resources :guest_regs, param: :uuid do
    member do
      post :approve
    end

    collection do
      get :sent
      get :approved
      post :confirm
    end
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
