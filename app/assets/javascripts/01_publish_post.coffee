$(document).ready ->
  return unless $('#publish_btn')
  $("#publish_btn").on "click", (e) ->
    f = $(this).closest "form"
    f.append "<input type='hidden' name='post[publish]' value='true' id='post_publish' />"
    f.submit()


