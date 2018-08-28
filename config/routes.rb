class SubdomainConstraint

  def self.matches?(request)
    request.subdomain.present? && request.subdomain != 'www'
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  constraints SubdomainConstraint do
    resources :tenants
  end
  # resources :registrations
  scope module: :api do
    namespace :icici do
      namespace :v1 do

        resources :api , only: [] do
          collection do
            post :callback
          end
        end

        resources :bankings, only:[] do
          collection do
            post :register
            post :deregister
            post :statement
            post :callback
          end
        end

        resources :payments, only: [] do
          collection do
            post :pay
            post :generate_otp
            post :verify_otp
            get :fetch_mobile
            get :transaction_status
            get :balance_enquiry
          end
        end

      end
    end
  end
end
