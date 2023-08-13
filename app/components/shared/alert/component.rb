# frozen_string_literal: true

class Shared::Alert::Component < ApplicationComponent
  renders_one :actions

  # @param [String] message
  # @param [Symbol] type
  def initialize(message:, type: :success, dissmissable: true)
    @message = message
    @type = type.to_sym
    @dissmissable = dissmissable
  end

  private

  ##
  # @return [String (frozen)]
  ##
  def bg_color
    return :green if :success == @type
    return :red if :error == @type
    return :blue if :info == @type
    return :amber if :warning == @type
    
    :yellow
  end
end
