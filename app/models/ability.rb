class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    if user.admin?
      can :manage, :all
    end

    if user.artist?
      can :manage, ArtistDetail, user_id: user.id
      can :manage, Artwork, user_id: user.id
      can :link, Artwork
      can :create, Comment
      can :update, Comment, user_id: user.id
      can :destroy, Comment, user_id: user.id
      can :follow, User
    end

    if user.user?
      can :like, Artwork
      can :create, Comment
      can :update, Comment, user_id: user.id
      can :destroy, Comment, user_id: user.id
      can :follow, User
    end

    can :manage, User, user_id: user.id
    can :read, Artwork
    can :read, Comment
  end
end
