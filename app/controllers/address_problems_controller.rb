class AddressProblemsController < ApplicationController
  def index
    skip_authorization
    skip_policy_scope

    @records = AddressProblem.records
  end
end
