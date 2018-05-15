class User < ApplicationRecord

  ##################################################################################
  ## Rails also have "has_secure_password" method to serve password functionality ##
  ##################################################################################

  include BCrypt

  # Associations
  has_many :tasks

  # Validations
  validates :email, :password, presence: true
  validates :email, email: true, uniqueness: true, allow_blank: true

  # Public instance methods
  def password
    return password_hash if password_hash.blank?
    @password ||= Password.new(password_hash)
  end

  def password=(password_arg)
    return password_arg if password_arg.blank?
    self.password_hash = Password.create(password_arg)
  end

  def validate_password(password)
    self.password == password
  end

end
