class User < ApplicationRecord

  ##################################################################################
  ## Rails also have "has_secure_password" method to serve password functionality ##
  ##################################################################################

  include BCrypt

  # Associations
  has_many :tasks

  # Validations
  validates :email, :password, presence: true
  validates :email, uniqueness: true

  # Public instance methods
  def password
    @password ||= Password.new(password_hash)
  end

  def password=(password_arg)
    self.password_hash = Password.create(password_arg)
  end

end
