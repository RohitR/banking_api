class Tenant < ApplicationRecord
  after_create :create_schema
  before_create :create_api_key
  validates_uniqueness_of :api_key

  private

  def create_schema
    Apartment::Tenant.create(subdomain)
  end

  def create_api_key
    self.api_key = SecureRandom.hex(32)
  end
end
