class Descriptor < ApplicationRecord

  # Scopes.
  default_scope { order(:label) }
  
  # Defaults.
  attribute :color,
            default: "#000000"

  # Validation.
  validates :label,
            presence: true,
            uniqueness: { scope: :type, case_sensitive: false }
  validates :color,
            presence: true,
            format: { with: /\A#(?:[A-F0-9]{3}){1,2}\z/i }

  # Define options for type.
  def self.options_for_type
    [
      ['Hunger Level', 'HungerLevel'],
      ['Energy Level', 'EnergyLevel'],
      ['Concentration Level', 'ConcentrationLevel'],
      ['Mood', 'Mood']
    ]
  end

end
