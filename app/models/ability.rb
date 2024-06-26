# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post
    # can :read, Comment
    return unless user.present?

    can :manage, :all if user.admin?
    if user.normal? || user.editor? || user.moderator?
      can %i[read create], Comment
      can :update, Comment, { user_id: user.id }
      can %i[update destroy], Comment if user.moderator?
    end
    return unless user.editor?

    can :create, Post
    can :update, Post, user_id: user.id

    # Define abilities for the passed in user here. For example:
    #
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
