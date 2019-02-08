class EnergyLevel < Descriptor

  # Associations.
  has_many  :entries,
            dependent: :nullify

end