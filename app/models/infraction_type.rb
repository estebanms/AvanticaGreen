class InfractionType < ActiveRecord::Base
  # might be useful for statistics
  has_many :infractions, :dependent => :restrict_with_exception

  validates :name, :presence => true, :uniqueness => true
  validates :points, :numericality => { allow_nil: false, :only_integer => true, :greater_than_or_equal_to => 0 }

  scope :active, -> { where(:active => true) }

  def to_s
    self.name
  end
end
