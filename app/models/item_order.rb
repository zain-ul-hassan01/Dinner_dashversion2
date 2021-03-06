# frozen_string_literal: true

class ItemOrder < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :quatity, :subtotal, numericality: { only_integer: true, greater_than: 0 }
end
