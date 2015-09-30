$(document).ready ->
  SUCCESS_URL = "/posts/congratulations-you-have-applied-to-the-devschool"

  $("input#enrollment_weeks_12").prop("checked", true)
  $("input#enrollment_pay_option_prepay").prop("checked", true)

  $("form#new_enrollment").submit (e) ->
    e.preventDefault()
    button = $("input[type=submit]")
    button.attr("disabled", "disabled")
    res = $.post "/enrollments.json", $(this).serialize()
    res.done ->
      eId = JSON.parse(res.responseText)['id']
      document.location.href = SUCCESS_URL
    res.fail ->
      button.removeAttr("disabled")
      errors = JSON.parse(res.responseText)['errors']
      $.each errors, (k, v, i) ->
        $("#enrollment_#{k}").css("border", "1px solid red")
        $("#enrollment_#{k}_error").html("That #{k} #{v[0]}")
