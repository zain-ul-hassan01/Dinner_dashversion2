# frozen_string_literal: true

# cartindexservice
class CartService
  attr_reader :args

  def initialize(*args)
    case args.size
    when 2
      @check = args[0]
      @id = args[1]
    when 3
      @remove = args[0]
      @item = args[1]
      @cart = args[2]
    end
  end

  def show_carts
    if @check.blank?
      @carts = Cart.all.find_user_cart(@id)
      @total = Cart.calculate_total(@id)
    else
      @carts = @check
      @total = @check.sum(:subtotal)
    end
    [@carts, @total]
  end

  def update_cart
    ActiveModel::Type::Boolean.new.cast(@remove) ? remove_item(@item) : nil
    remove_item(@item) if @cart.quantity.zero?
    @item.price * @cart.quantity
  end

  def remove_item(item)
    cart = Cart.find_by(item_id: item.id)
    Cart.delete(cart.id)
  end
end