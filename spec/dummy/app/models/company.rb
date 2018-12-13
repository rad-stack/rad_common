class Company < ApplicationRecord
  include Authority::Abilities
  include RadCompany
end
