# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :item_orders, dependent: :destroy
  has_many :items, through: :item_orders, dependent: :destroy

  scope :user_orders, ->(user_id, restaurant_id) { where(user_id: user_id, restaurant_id: restaurant_id) }
  scope :restaurant_orders, ->(restaurant_id) { where(restaurant_id: restaurant_id) }
  scope :find_orders_in_item_order, ->(id) { ItemOrder.all.where(order_id: id) }

  validates :status, presence: true
  validates :total, numericality: { only_integer: true, greater_than: 0 }
  enum status: {
    ordered: 0,
    completed: 1,
    cancelled: 2
  }
end
