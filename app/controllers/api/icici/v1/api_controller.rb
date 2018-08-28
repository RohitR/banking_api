module Api
  module Icici
    module V1
      class ApiController < ApplicationController

        def callback
          Apartment::Tenant.switch(decrypted_params['AGGRID']) do
            if registration_callback?
              bank_registration.update_attributes(status: decrypted_params['STATUS'].parameterize.underscore)
              data = {urn: decrypted_params['URN'], status: decrypted_params['STATUS'].parameterize.underscore}
            else
              payment_transaction.update_attributes(status: decrypted_params['TXNSTATUS'].parameterize.underscore)
              data = {unique_id: decrypted_params['UNIQUEID'], status: decrypted_params['TXNSTATUS'].parameterize.underscore}
            end
            IciciService::Request.new(data).spp_callback
          end
        end

        private

        def decrypted_params
          @decrypted_params ||= IciciService::Crypto.new(params[:data]).decrypt if params[:data]
        end

        def registration_callback?
          decrypted_params['USERID'] && decrypted_params['CORPID'] && decrypted_params['AGGRID'] && decrypted_params['URN']
        end

        def bank_registration
          BankRegistration.where(
            "details->>'user_id' = #{decrypted_params['USERID']} and\
             details->>'corp_id' = #{decrypted_params['CORPID']} and\
             details->>'aggr_id' = #{decrypted_params['AGGRID']} and\
             details->>'urn' = #{decrypted_params['URN']}"
            ).first
        end

        def payment_transaction
          Payment.where(urn: decrypted_params['URN']).where(
            "details->>'user_id' = #{decrypted_params['USERID']} and\
             details->>'corp_id' = #{decrypted_params['CORPID']} and\
             details->>'aggr_id' = #{decrypted_params['AGGRID']} and\
             details->>'aggr_name' = #{decrypted_params['AGGRNAME']} and\
             details->>'unique_id' = #{decrypted_params['UNIQUEID']} and\
             details->>'req_id' = #{decrypted_params['REQUESTID']}"
            ).first
        end
      end
    end
  end
end
