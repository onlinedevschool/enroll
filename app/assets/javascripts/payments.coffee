$(document).ready ->
  handleStripeResponse = (form, button, status, response) ->
    if (response.error)
      button.removeAttr("disabled")
      $(".payment-errors").html(response.error.message)
    else
      token = response['id']
      input = $("<input name='payment[token]' value='" + token + "' style='display:none;' />")
      form.append(input[0])
      url = window.location.pathname.replace("/new",".json")
      res = $.post url, form.serialize()
      res.done ->
        html = ["<div class='page-header text-center'>",
                "<h2>Welcome to devschool!</h2>",
                "<h4>Your payment was successfully processed</h4>",
                "</div>",
                "<p>Jim OKelly will be your new web development instructor!</p>",
                "<p>He will email you today with instructions on how to proceed and enter the chat room.</p>"]

        console.debug(html)
        $(".pane").html(html.join("\n"))
      res.fail ->
        $(".payment-errors").html("There was an error charging your card. Please initiate a live chat on this page to fix the issue.")
        console.debug JSON.parse(res.responseText)

  $("input.card-number").payment('formatCardNumber')

  $("form#new_payment").on "submit", (e) ->
    form = $(this)
    button = $("button[type=submit]")
    e.preventDefault()
    button.attr("disabled", "disabled")
    Stripe.setPublishableKey(form.data('stripe-publishable-key'))
    attrs = {
      number: $('.card-number').val(),
      cvc: $('.card-cvc').val(),
      exp_month: $('.card-expiry-month').val(),
      exp_year: $('.card-expiry-year').val()
    }

    Stripe.createToken attrs, (status, response) ->
      handleStripeResponse(form, button, status, response)
