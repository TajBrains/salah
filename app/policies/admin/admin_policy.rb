# frozen_string_literal: true

module Admin
  ##
  # Admin Policy class
  ##
  class AdminPolicy < ApplicationPolicy
    def index?
      user.admin?
    end
  end
end
