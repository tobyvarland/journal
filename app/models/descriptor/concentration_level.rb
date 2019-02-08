class ConcentrationLevel < Descriptor

  # Associations.
  has_many  :entries,
            dependent: :nullify

end