module Api
  module Icici
    module V1
      class PaymentsController < ApiController
        around_action :encrypt_for_spp

        def pay
          # response = IciciService::Request.new(decrypted_params, :transaction).response
          # if response.success?
            payment = Payment.new(details: decrypted_params)
            payment.save
          # end
          {'Response': 'success'}
        end

        def generate_otp
          IciciService::Request.new(decrypted_params, :otp_creation).response
        end

        def verify_otp
          Icici::Request.new(decrypted_params, :transaction_otp).response
        end

        def fetch_mobile
          IciciService::Request.new(decrypted_params, :mobile_fetch).response
        end

        def transaction_status
          IciciService::Request.new(decrypted_params, :transaction_inquiry).response
        end

        def balance_enquiry
          IciciService::Request.new(decrypted_params, :balance_inquiry).response
        end
        
        private

        def encrypt_for_spp
          response = yield
          render Crypto.new(response).encrypt_for_spp
        end

      end
    end
  end
end