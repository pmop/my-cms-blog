class User < ApplicationRecord
  enum role: [:normal, :editor, :moderator, :admin]

  after_initialize :set_default_role, :if => :new_record?

  # Guest is not technically a role
  def guest?
    # Check at the database if user is persisted so we may know if he's a guest
    persisted?
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_and_belongs_to_many :posts, dependent: :destroy

  has_one_attached :avatar

  def set_default_role
    self.role = :normal
  end
end
