class Ability
  include CanCan::Ability
  
  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user

    # set authorizations for different user roles
    if user.role? :admin
      # they get to do it all
      can :manage, :all
    elsif user.role? :customer
      can :read, Item
      can :read, Order do |this_order|
        my_orders = user.orders.map(&:id)
        my_orders.include? this_order.id
      end
    else
      can :read, Item
      can :create, Customer
    end

  end
end