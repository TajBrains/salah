# frozen_string_literal: true

class Shared::ModalComponent < ApplicationComponent
  include Turbo::FramesHelper
  include Turbo::StreamsHelper

  attr_reader :title, :width, :target

  def initialize(target: "modal", title: "", width: "40%")
    @target = target
    @title = title
    @width = width
  end

  def call
    turbo_frame_tag target do
      content_tag :div, class: "modal-wrapper", data: {controller: "modal", action: "turbo:submit-end->modal#submitEnd keyup@window->modal#closeWithKeyboard click@window->modal#closeBackground"} do
        content_tag :div, class: "modal", style: "width: #{width};", data: {modal_target: "modal"} do
          concat header_component unless title.blank?
          concat content_tag(:div, content, class: "p-4")
        end
      end
    end
  end

  private

  def header_component
    content_tag :div, class: "bg-gray-800 py-2 px-4 flex items-center justify-between sticky top-0" do
      concat content_tag(:h1, title, class: "text-lg font-bold text-white")
      concat svg_tag("dissmiss", class: "fill-white h-8 w-8 transition hover:bg-gray-500 rounded-lg p-1 cursor-pointer", "data-action": "click->modal#hideModal")
    end
  end
end
