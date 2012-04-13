module Ldap
  def self.find_all_ldap_users
    # load settings from devise_ldap config file
    ldap_settings = self.load_ldap_connection_settings
    # create ldap connection
    ldap = Net::LDAP.new(:host => ldap_settings["host"], :port => ldap_settings["port"])
    all_ldap_users = Array.new
    # define search parameters
    treebase = ldap_settings['base']
    filter = Net::LDAP::Filter.eq(ldap_settings["attribute"], "*")
    attrs = ["mail", "sn", "givenName"]
    # search, according to params
    ldap.search(:base => treebase, :filter => filter, :attributes => attrs) do |entry|
      all_ldap_users.push(Hash["mail" => Ldap.ldap_object_to_string(entry[:mail]), "last_names" => Ldap.ldap_object_to_string(entry[:sn]), "name" => Ldap.ldap_object_to_string(entry[:givenName])])
    end
    all_ldap_users
  end

  def self.ldap_object_to_string object
    object.to_s.gsub(/[\[\]\"]*/, "")
  end

  def self.load_ldap_connection_settings
    #TODO : find out if these settings are already available (already loaded by devise)
    YAML.load_file("#{::Rails.root.to_s}/config/ldap.yml")[::Rails.env.to_s]
  end
end
