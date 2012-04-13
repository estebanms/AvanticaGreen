class User < ActiveRecord::Base
  has_one :player, :dependent => :destroy

  # before_save :get_ldap_lastname
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  # devise :ldap_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :ldap_authenticatable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :email, :password_confirmation, :remember_me

  def get_ldap_lastname
    #self.lastname = Devise::LdapAdapter.get_ldap_param(email,"sn")
  end
end
