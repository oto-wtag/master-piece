class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    if user.admin?
      can :manage, :all
    end

    if user.artist?
      can :create, Artwork
      can :update, Artwork, user_id: user.id
      can :destroy, Artwork, user_id: user.id
      can :manage, ArtistDetail, user_id: user.id
    end

    if user.user?
      can :follow, User
    end

    can :read, Artwork
    can :read, User
    can :like, Artwork
    can :create, Comment
    can [ :update, :destroy ], Comment, user_id: user.id
    can :manage, User, id: user.id
  end
end
