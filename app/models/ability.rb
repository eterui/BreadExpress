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
      can :manage, Order do |this_order|
        my_orders = user.customer.orders.map(&:id)
        my_orders.include? this_order.id
      end
      can :manage, Address do |this_address|
        my_addresses = user.addresses.map(&:id)
        my_addresses.include? this_address.id
      end
      can :read, Customer do |this_customer|
        my_customer = user.customer.id
        my_customer == this_customer.id
      end
    elsif user.role? :shipper
      can :manage, :all


    else
      can :read, Item
      can :create, Customer
      can :create, User
    end

  end
end