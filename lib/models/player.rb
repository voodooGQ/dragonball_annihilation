# frozen_string_literal: true
#
# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  name       :string
#  password   :string
#  race       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "active_record"

class Player < ActiveRecord::Base
  attr_accessor :connection

  VALID_RACES = %w[saiyan human namek icer mutant android]

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :race, presence: true, inclusion: {
    in: VALID_RACES, message: "%{value} is not a valid race"
  }

  belongs_to :room, required: true, autosave: true
  has_one :area, through: :room

  [:admin?, :is_admin?].each{ |m| alias_attribute m, :admin }

  def connected?
    !!@connection
  end

  def roommates
    room.connected_occupants.reject{|o| o == self}
  end

  def areamates
    Game.instance.players.select{|p| p.area == area}
  end

  def method_missing(m, *args, &block)
    @connection.send(m, *args, &block)
  end

  def respond_to_missing?(m, include_private = false)
    @connection.respond_to?(m, include_private) || super
  end

  def self.race_list
    VALID_RACES.join(", ")
  end
end
