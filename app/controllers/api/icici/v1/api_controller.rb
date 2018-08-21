module Icici
  module V1
    class ApiController < ApplicationController
      before_action :decrypted_params

      private

      def decrypted_params
        IciciService::Crypto.new(parans[:data]).decrypt if parans[:data]
      end
    end
  end
end
