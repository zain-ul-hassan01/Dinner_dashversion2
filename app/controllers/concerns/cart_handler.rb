# frozen_string_literal: true

# Cart helper
module CartHandler
  def removeitem(item)
    item1 = Item.find_by(title: item)
    cart = Cart.find_by(item_id: item1.id)
    Cart.delete(cart.id) if cart.present?
  end

  def quantity_updation(status)
    count = session[:cart][params[:item_title]]
    to_boolean(status) ? count += 1 : count -= 1
    count
  end

  def check_count?(count)
    session[:cart].delete(params[:item_title]) if count.zero?
  end

  def create_order_according_to_cart(carts, total)
    carts.each do |cart|
      item = Item.find_by(title: cart[0])
      restaurant_id = item.restaurant_id
      order_create(cart, restaurant_id, total, item)
    end
  end

  def order_create(cart, restaurant_id, total, item)
    order = Order.find_or_create_by!(user_id: current_user.id, restaurant_id: restaurant_id, status: 0,
                                     total: total.to_i)
    if order.new_record?
      ItemOrder.find_or_create_by!({ order_id: order.id, quatity: cart[1], subtotal: item.price * cart[1],
                                     item_id: item.id })
    else
      @orders = Cart.find_orders(restaurant_id)
      ItemOrder.create!({ order_id: @orders.last.id, quatity: cart[1], subtotal: item.price * cart[1],
                          item_id: item.id })
    end
  end
end
