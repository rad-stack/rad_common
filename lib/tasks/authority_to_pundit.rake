task authority_to_pundit: :environment do
  Rails.application.eager_load!

  exclude = [{ class_name: 'Company', policy_name: 'company' },
             { class_name: 'SecurityRole', policy_name: 'security_role' },
             { class_name: 'User', policy_name: 'user' }]

  policies = ApplicationRecord.subclasses.map { |item| { class_name: item.name, policy_name: item.name.underscore } } - exclude

  File.rename Rails.root.join('app', 'authorizers'), Rails.root.join('app', 'policies')

  FileUtils.cp '../rad_common/spec/dummy/app/policies/application_policy.rb', Rails.root.join('app', 'policies', './')
  FileUtils.copy_entry '../rad_common/spec/dummy/lib/templates', Rails.root.join('lib', 'templates')

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
  system "find . -type f -name \"*authorizer.rb\" -print0 | xargs -0 sed -i '' -e 's/resource/record/g'"

  policies.each do |policy|
    path = Rails.root.join('app', 'policies', "#{policy[:policy_name]}_policy.rb")
    next if File.exist?(path)

    # system "bundle exec rails g pundit:policy #{policy_name}"
    open(path, 'w') do |file|
      file << "class #{policy[:class_name]}Policy < ApplicationPolicy \n"
      file << "end\n"
    end
  end

  File.delete Rails.root.join('config', 'initializers', 'authority.rb')
end

def search_and_replace(search_string, replace_string)
  system "find . -type f -name \"*.rb\" -print0 | xargs -0 sed -i '' -e 's/#{search_string}/#{replace_string}/g'"
end
