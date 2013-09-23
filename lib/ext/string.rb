class String
  
  def ldap_escape
   eval %Q{"#{self}"}
  end

  def ldap_escape!
    self.replace(self.ldap_escape)
  end
end
