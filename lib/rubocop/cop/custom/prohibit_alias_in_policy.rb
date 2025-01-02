module RuboCop
  module Cop
    module Custom
      # Custom cop to prohibit the use of `alias` in files ending with `_policy.rb`.
      class ProhibitAliasInPolicy < RuboCop::Cop::Base
        # Message displayed when an offense is detected
        MSG = "Avoid using `alias` in files ending with '_policy.rb'."

        # Specify the types of nodes to observe
        def on_alias(node)
          # Check the file path
          if processed_source.file_path.end_with?('_policy.rb')
            add_offense(node, message: MSG)
          end
        end

        # Also capture `alias_method` since it's an alternative syntax
        def on_send(node)
          if node.method?(:alias_method) && processed_source.file_path.end_with?('_policy.rb')
            add_offense(node, message: MSG)
          end
        end
      end
    end
  end
end
