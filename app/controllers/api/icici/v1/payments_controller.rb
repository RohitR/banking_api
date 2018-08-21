module Icici
  module V1
    class PaymentsController

      def pay
        response = IciciService::Request.new(decrypted_params, :transaction).response
        if response.success?
          payment = Payment.new(details: decrypted_params)
          payment.save
        end
        render response.data
      end

      def generate_otp
        response = IciciService::Request.new(decrypted_params, :otp_creation).response
        render response.data
      end

      def verify_otp
        response = Icici::Request.new(decrypted_params, :transaction_otp).response
        render response.data
      end

      def fetch_mobile
        response = IciciService::Request.new(decrypted_params, :mobile_fetch).response
        render response.data
      end

      def transaction_status
        response = IciciService::Request.new(decrypted_params, :transaction_inquiry).response
        render response.data
      end

      def balance_enquiry
        response = IciciService::Request.new(decrypted_params, :balance_inquiry).response
        render response.data
      end
      
    end
  end
end