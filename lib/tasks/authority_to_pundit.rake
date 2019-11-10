task authority_to_pundit: :environment do
  File.delete Rails.root.join('config', 'initializers', 'authority.rb')
  File.rename Rails.root.join('app', 'authorizers'), Rails.root.join('app', 'policies')

  FileUtils.cp '../rad_common/spec/dummy/app/policies/application_policy.rb', Rails.root.join('app', 'policies', './')
  FileUtils.cp '../rad_common/spec/dummy/app/policies/company_policy.rb', Rails.root.join('app', 'policies', './')

  search_and_replace 'include Authority::Abilities', ''
  search_and_replace 'include Authority::UserAbilities', ''
  search_and_replace 'authorize_action_for', 'authorize'
  search_and_replace 'Authorizer < ApplicationAuthorizer', 'Policy < ApplicationPolicy'
  search_and_replace '# class rules', ''

  search_and_replace 'def self.creatable_by?(_user)', 'def create?'
  search_and_replace 'def self.creatable_by?(user)', 'def create?'

  search_and_replace 'def self.readable_by?(_user)', 'def show?'
  search_and_replace 'def self.readable_by?(user)', 'def show?'

  search_and_replace 'def self.updatable_by?(_user)', 'def update?'
  search_and_replace 'def self.updatable_by?(user)', 'def update?'

  search_and_replace 'def self.deletable_by?(_user)', 'def destroy?'
  search_and_replace 'def self.deletable_by?(user)', 'def destroy?'

  search_and_replace 'Authorizer, type: :authorizer do', 'Policy, type: :policy do'

  policy_names.each do |policy_name|
    next if File.exist?(Rails.root.join('app', 'policies', "#{policy_name}_policy.rb"))

    system "bundle exec rails g pundit:policy #{policy_name}"
  end
end

def search_and_replace(search_string, replace_string)
  system "find . -type f -name \"*.rb\" -print0 | xargs -0 sed -i '' -e 's/#{search_string}/#{replace_string}/g'"
end

def policy_names
  Rails.application.eager_load!
  all_items = ApplicationRecord.subclasses.map { |item| item.name.underscore }
  all_items - %w[company security_role user]
end
