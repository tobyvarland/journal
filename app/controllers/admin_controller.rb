class AdminController < ApplicationController

  # GET /admin
  def index
    @new_descriptor = Descriptor.new
    @energy_levels = EnergyLevel.all
    @hunger_levels = HungerLevel.all
    @concentration_levels = ConcentrationLevel.all
    @moods = Mood.all
  end

end