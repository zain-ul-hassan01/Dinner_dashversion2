# frozen_string_literal: true

# order Policy Authorization
class OrderPolicy < ApplicationPolicy
    def index?
      true
    end
  
    def show?
      true
    end
  
    def update?
      user ? user.admin? : false
    end
  
    def search?
      user ? user.admin? : false
    end
end
  