module RuboCop
  module Cop
    module Custom
      class ProhibitAliasInPolicy < RuboCop::Cop::Base
        MSG = 'Avoid using `alias` in Pundit Policy Files'.freeze

        def on_alias(node)
          return unless processed_source.file_path.end_with?('_policy.rb')

          add_offense(node, message: MSG)
        end
      end
    end
  end
end
