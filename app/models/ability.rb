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
      can :like, Artwork
      can :create, Comment
      can [ :update, :destroy ], Comment, user_id: user.id
      can :follow, User
    end

    if user.user?
      can :like, Artwork
      can :create, Comment
      can [ :update, :destroy ], Comment, user_id: user.id
      can :follow, User
    end

    can :read, Artwork
    can :read, Comment
    can :manage, User, user_id: user.id
  end
end
