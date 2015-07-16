$(document).ready(function(){
  Stripe.setPublishableKey($("meta[name='stripe-publishable-key']").attr("value"));

  $("#stripe-form").on("submit", function(e){
      e.preventDefault();
      Stripe.card.createToken({
          number:    $('#card-number').val(),
          cvc:       $('#cvc').val(),
          exp_month: $('#date_month').val(),
          exp_year:  $('#date_year').val()
    }, stripeResponseHandler);
    $("#submit-button").prop('disabled', true);
  });

  var stripeResponseHandler = function (status, response) {
    if (response.error) {
      // Show the errors on the form
      $("#stripe-errors").text(response.error.message);
      $("#submit-button").prop('disabled', false);
    } else {
      // We set the stripe_token hidden field with the stripe token we got
      // form the Stripe API and then we submit the form to our server
      $("#stripe_token").val(response.id);
      $("#server-form").submit();
    }
  }

});
