class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :tenant, optional: true

  attr_accessor :company_name

  def setup_tenant!(company_name)
    tenant = Tenant.create!(name: company_name)
    update!(tenant: tenant)
    tenant
  end
end
