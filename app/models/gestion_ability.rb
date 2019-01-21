class GestionAbility
  include CanCan::Ability

  def initialize (user)
    user.roles.each { |role| send(role.name.downcase, user) }
  end

  def admin (user)
    can :manage, :all
  end

  def client (user)
    can :manage, :all   #######TEMPORAIRE!!!
    #cannot :manage, :all
    #can :manage, Client::ReservationsController
    #can :manage, Client::ProfilesController
    #can :read, Room
  end

  def employee (user) #A VENIR
    #can :manage, [reservation, room, user]
  end

  def cleaning (user) #A VENIR
    #can :read, :room
  end
end