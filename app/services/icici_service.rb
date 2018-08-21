module IciciService
  API_END_POINT = 'https://apigwuat.icicibank.com:8443'

  EVENT_URL_MAP = {
    registration: '/api/Corporate/CIB/v1/Registration/Relyon',
    balance_inquiry: '/api/Corporate/CIB/v1/BalanceInquiry/Relyon',
    transaction: '/api/Corporate/CIB/v1/Transaction/Relyon',
    transaction_inquiry: '/api/Corporate/CIB/v1/TransactionInquiry/Relyon',
    validate_linked_account: '/api/Corporate/CIB/v1/ValidateLinkedAccount/Relyon',
    account_statement: '/api/Corporate/CIB/v1/AccountStatement/Relyon',
    de_registration: '/api/Corporate/CIB/v1/Deregistration/Relyon',
    otp_creation: '/api/Corporate/CIB/v1/Create/Relyon',
    transaction_otp: '/api/Corporate/CIB/v1/TransactionOTP/Relyon',
    mobile_fetch: '/api/Corporate/CIB/v1/MobileFetch/Relyon'
  }
end