module JournalHelper

  # Return placeholder text for entry.
  def meal_placeholder(entry)
    return "" if entry.blank?
    "Last meal: #{entry.meal} (#{entry.entry_at.strftime "%m/%d %l:%M %P"})"
  end

  # Substitute links for hashtags.
  def render_with_hashtags(text)
    text.gsub(/(?:#(\w+))/) { hashtag_link($1) }
  end

  # Format link for individual hashtag.
  def hashtag_link(hash)
    link_to "##{hash}", "#", class: "search-for-hashtag"
  end

  # Return HTML for pill.
  def descriptor_pill(d)
    return "" if d.blank?
    target = ""
    case d.type
    when "HungerLevel"
      target = "#with_hunger_level"
    when "EnergyLevel"
      target = "#with_energy_level"
    when "ConcentrationLevel"
      target = "#with_concentration_level"
    when "Mood"
      target = "#with_mood"
    end
    link_to d.label,
            "#",
            class: "badge filter-on-click",
            data: { target: target, value: d.id },
            style: "background-color: #{d.color}; color: #{auto_text_color(d.color)};"
  end

  # Get text color (white or black) for given descriptor color.
  def auto_text_color(bg)

    # Get individual components of background color.
    red_hex = bg[1..2]
    green_hex = bg[3..4]
    blue_hex = bg[5..6]
    red = red_hex.hex
    green = green_hex.hex
    blue = blue_hex.hex

    # Return text color.
    if ((red * 0.299 + green * 0.587 + blue * 0.114) > 186)
      return "#000000"
    else
      return "#ffffff"
    end

  end

end