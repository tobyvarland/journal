$(document).on 'turbolinks:load', ->

  # Clear modal when reset button clicked.
  $(".clear-new-form-modal").click ->
    $("#new-entry-modal").modal('hide')

  # Enable popovers & tooltips.
  $('[data-toggle="popover"]').popover()
  $('[data-toggle="tooltip"]').tooltip()

  # Handle cloning an entry.
  $(".clone-entry").click (event)->
    event.preventDefault()
    entry = $(@).closest("tr").data("entry")
    $("#entry_meal").val(entry.meal)
    $("#entry_hunger_level_id").val(entry.hunger_level_id)
    $("#entry_energy_level_id").val(entry.energy_level_id)
    $("#entry_concentration_level_id").val(entry.concentration_level_id)
    $("#entry_mood_id").val(entry.mood_id)
    $("#entry_physiological_reaction").val(entry.physiological_reaction)
    $("#entry_notes").val(entry.notes)
    $("#new-entry-modal").modal()

  # Set up filter-on-click links.
  $(".filter-on-click").click (event)->
    event.preventDefault()
    link = $(@)
    $(link.data("target")).val(link.data("value")).form().submit()
  $(".search-for-hashtag").click (event)->
    event.preventDefault()
    link = $(@)
    target = $("#with_search_term")
    value = target.val() + " " + link.text()
    target.val(value.replace(/^\s+|\s+$/g, "")).form().submit()

  # Auto submit filter forms.
  $(".filter-form select").on
    change: ->
      $(@).form().submit();
  $(".filter-form input[type='text']").on
    change: ->
      $(@).form().submit();

  # Set up time shortcut buttons.
  $("body.controller-journal .time-changer").on
    click: ->
      val = $(@).data('value')
      target = $("body.controller-journal #entry_entry_at")
      target.val(val)

  # Set up autocomplete fields.
  # $(".journal-autocomplete").each (index, elem) =>
  #   this_element = $(elem)
  #   this_element.autocomplete({
  #     source: this_element.data("autocomplete-source")
  #   })