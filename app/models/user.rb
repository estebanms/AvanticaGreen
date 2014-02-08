class User < ActiveRecord::Base
  has_one :player, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  # devise :ldap_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  if USE_LDAP
    devise :ldap_authenticatable, :rememberable, :trackable, :validatable
  else
    devise :database_authenticatable, :rememberable, :trackable, :validatable
  end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
end
