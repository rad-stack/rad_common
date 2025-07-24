module Pace
  class NetworkLocation < Base
    attr_accessor :name

    attr_accessor :location

    attr_accessor :id

    attr_accessor :type

    attr_accessor :host

    attr_accessor :port

    attr_accessor :user_name

    attr_accessor :password

    attr_accessor :_alias

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :topic_name

    attr_accessor :passive_ftp

    attr_accessor :file_separator

    attr_accessor :organization_company

    attr_accessor :topic_message

    attr_accessor :http_method

    attr_accessor :topic_function

    attr_accessor :is_super_eflow_connected

    attr_accessor :content_file_location

    attr_accessor :file_encryption_method

    attr_accessor :append_uuidto_topic_name

    attr_accessor :ftp_connection_timeout

    attr_accessor :read_only_location

    attr_accessor :is_secure

    attr_accessor :proxied

    attr_accessor :proxied_network_location

    attr_accessor :client_initiated_connection

    attr_accessor :super_eflow_url

    attr_accessor :do_not_cache_connection

    attr_accessor :use_experimental_modern_connections

    attr_accessor :topic_version

    attr_accessor :local_e_flow_id

    attr_accessor :http_connection_timeout

    attr_accessor :base_directory_pattern

    attr_accessor :file_location_connection_type

    attr_accessor :push_to_supere_flow

    attr_accessor :secured


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'location' => :'location',
        :'id' => :'id',
        :'type' => :'type',
        :'host' => :'host',
        :'port' => :'port',
        :'user_name' => :'userName',
        :'password' => :'password',
        :'_alias' => :'alias',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'topic_name' => :'topicName',
        :'passive_ftp' => :'passiveFTP',
        :'file_separator' => :'fileSeparator',
        :'organization_company' => :'organizationCompany',
        :'topic_message' => :'topicMessage',
        :'http_method' => :'httpMethod',
        :'topic_function' => :'topicFunction',
        :'is_super_eflow_connected' => :'isSuperEflowConnected',
        :'content_file_location' => :'contentFileLocation',
        :'file_encryption_method' => :'fileEncryptionMethod',
        :'append_uuidto_topic_name' => :'appendUUIDToTopicName',
        :'ftp_connection_timeout' => :'ftpConnectionTimeout',
        :'read_only_location' => :'readOnlyLocation',
        :'is_secure' => :'isSecure',
        :'proxied' => :'proxied',
        :'proxied_network_location' => :'proxiedNetworkLocation',
        :'client_initiated_connection' => :'clientInitiatedConnection',
        :'super_eflow_url' => :'superEflowURL',
        :'do_not_cache_connection' => :'doNotCacheConnection',
        :'use_experimental_modern_connections' => :'useExperimentalModernConnections',
        :'topic_version' => :'topicVersion',
        :'local_e_flow_id' => :'localEFlowID',
        :'http_connection_timeout' => :'httpConnectionTimeout',
        :'base_directory_pattern' => :'baseDirectoryPattern',
        :'file_location_connection_type' => :'fileLocationConnectionType',
        :'push_to_supere_flow' => :'pushToSupereFlow',
        :'secured' => :'secured'
      }
    end
  end
end
