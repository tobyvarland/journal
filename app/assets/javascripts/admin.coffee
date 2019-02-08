$(document).on 'turbolinks:load', ->
  setTimeout dismiss_alerts, 2000

dismiss_alerts = ->
  $("body.controller-admin .alert").alert('close')