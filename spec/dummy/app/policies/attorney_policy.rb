class AttorneyPolicy < ApplicationPolicy
  alias not_duplicate? destroy?
  alias reset_duplicates? destroy?
  alias merge_duplicates? destroy?
  alias show_current_duplicates? show?
  alias duplicate_do_later? destroy?
end
