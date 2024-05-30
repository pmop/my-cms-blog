# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable


  devise :database_authenticatable, :registerable,
    :timeoutable, :recoverable, :lockable, :confirmable,
    unlock_strategy: :time, lock_strategy: :failed_attempts,
    allow_unconfirmed_access_for: 2.weeks, reconfirmable: true



  enum role: %i[normal editor moderator admin]

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role = :normal
  end

  # Guest is not technically a role
  def guest?
    # Check at the database if user is persisted so we may know if he's a guest
    persisted?
  end


  has_many :posts

  has_one_attached :avatar
end
