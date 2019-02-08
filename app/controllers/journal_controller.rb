class JournalController < ApplicationController

  # Filter scope definitions.
  has_scope :sorted_by,
            only: :index,
            default: nil,
            allow_blank: true
  has_scope :with_hunger_level, only: :index
  has_scope :with_energy_level, only: :index
  has_scope :with_concentration_level, only: :index
  has_scope :with_mood, only: :index
  has_scope :with_search_term, only: :index

  # GET /admin
  def index
    @new_entry = Entry.new
    @entries = apply_scopes(Entry).includes(:hunger_level, :energy_level, :concentration_level, :mood).page(params[:page])
  end

end