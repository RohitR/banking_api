module Api
  module Icici
    module V1
      class BankingsController < ApiController
        wrap_parameters false

        def register
          binding.pry
          response = IciciService::Request.new(decrypted_params, :registration).response
          if response.success?
            icici = Icici.first_or_initialize(details: decrypted_params)
            icici.save
          end
          render response.data
        end

        def deregister
          response = IciciService::Request.new(decrypted_params, :deregistration).response
          if response.success?
            Icici.deregister
          end
          render response.data
        end

        def statement
        end
      end
    end
  end
end