class Entry < ApplicationRecord

  # Associations.
  belongs_to  :hunger_level,
              optional: true
  belongs_to  :energy_level,
              optional: true
  belongs_to  :concentration_level,
              optional: true
  belongs_to  :mood,
              optional: true
  belongs_to  :subject,
              class_name: "Entry",
              optional: true
  has_many  :reactions,
            class_name: "Entry",
            foreign_key: "subject_id",
            dependent: :destroy

  # Scopes.
  scope :for_meal, -> { where(subject_id: nil) }
  scope :sorted_by, ->(sort) {
    case sort
    when 'oldest'
      sort_by = 'entries.entry_at'
    else
      sort_by = 'entries.entry_at DESC'
    end
    order(sort_by)
  }
  scope :with_hunger_level, ->(id) { where("entries.hunger_level_id = ?", id) unless id.nil? }
  scope :with_energy_level, ->(id) { where("entries.energy_level_id = ?", id) unless id.nil? }
  scope :with_concentration_level, ->(id) { where("entries.concentration_level_id = ?", id) unless id.nil? }
  scope :with_mood, ->(id) { where("entries.mood_id = ?", id) unless id.nil? }
  scope :with_search_term, ->(term) {
    unless term.blank?
      search = ApplicationController.helpers.split_search_terms(term)
      conditions = []
      parameters = {}
      term_index = 1
      search[:include].each do |t|
        key = "search#{term_index}"
        conditions << "(entries.meal LIKE :#{key} OR entries.physiological_reaction LIKE :#{key} OR entries.notes LIKE :#{key} OR subjects_entries.meal LIKE :#{key} OR subjects_entries.physiological_reaction LIKE :#{key} OR subjects_entries.notes LIKE :#{key})"
        parameters[key] = "%#{t}%"
        term_index += 1
      end
      search[:exclude].each do |t|
        key = "search#{term_index}"
        conditions << "(entries.meal NOT LIKE :#{key} AND entries.physiological_reaction NOT LIKE :#{key} AND entries.notes NOT LIKE :#{key} AND subjects_entries.meal NOT LIKE :#{key} AND subjects_entries.physiological_reaction NOT LIKE :#{key} AND subjects_entries.notes NOT LIKE :#{key})"
        parameters[key] = "%#{t}%"
        term_index += 1
      end
      left_outer_joins(:subject).where(conditions.join(' AND '), parameters.symbolize_keys)
    end
  }
  
  # Validations.
  validate  :must_have_meal_or_subject
  validate  :must_enter_something
  def must_have_meal_or_subject
    if meal.blank? && subject_id.nil?
      errors.add(:meal, "can't be blank when no previous meal exists")
    end
  end
  def must_enter_something
    if meal.blank? && physiological_reaction.blank? && notes.blank? && hunger_level_id.blank? && energy_level_id.blank? && concentration_level_id.blank? && mood_id.blank?
      errors.add(:meal, "can't be blank when you don't enter anything else")
    end
  end

  # Callbacks.
  before_create do
    self.subject_id = nil unless self.meal.blank?
  end
  after_initialize :load_previous_meal_as_subject, if: :new_record?
  def load_previous_meal_as_subject
    previous_meal = Entry.for_meal.order("entry_at DESC").first
    unless previous_meal.blank?
      self.subject = previous_meal
    end
    self.entry_at ||= DateTime.now.change(sec: 0)
  end

  # Methods.
  def hunger_level_label
    hunger_level.try(:label)
  end
  def hunger_level_label=(label)
    self.hunger_level = HungerLevel.find_or_create_by(label: label) if label.present?
  end
  def energy_level_label
    energy_level.try(:label)
  end
  def energy_level_label=(label)
    self.energy_level = EnergyLevel.find_or_create_by(label: label) if label.present?
  end
  def concentration_level_label
    concentration_level.try(:label)
  end
  def concentration_level_label=(label)
    self.concentration_level = ConcentrationLevel.find_or_create_by(label: label) if label.present?
  end
  def mood_label
    mood.try(:label)
  end
  def mood_label=(label)
    self.mood = Mood.find_or_create_by(label: label) if label.present?
  end
  def as_json(options = {})
    super((options || {}).merge({
      :methods => [:hunger_level_label, :energy_level_label, :concentration_level_label, :mood_label]
    }))
  end

  # Class methods.
  def self.options_for_sort
    [["Newest", "newest"], ["Oldest", "oldest"]]
  end

end