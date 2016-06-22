var incentru = incentru || {};
incentru.PinPage = {};

incentru.PinPage.onPageLoad = function() {
  this.form = $("#bid-form");
  this.submitBidBtn = this.form.find(".btn-primary");
  this.submitBidBtn.on("click", _.bind(this.submitBid, this));
  this.form.find("input[name=price],input[name=quantity]").on("keyup", _.bind(this.updateFullPrice, this));
  this.errorDiv = this.form.find("#bid-success");
  this.successDiv = this.form.find("#bid-success");
};

incentru.PinPage.submitBid = function() {
  if (this.submitBidBtn.is(":disabled")) {
    return false;
  }

  this.errorDiv.text("");
  this.successDiv.text("");

  var params = incentru.extra.serializeObject(this.form);
  if (params.price < incentru.pageData.minimumBid) {
    this.bidErrorMessage("Your bid must be at least $" + incentru.extra.toTwoDecimals(incentru.pageData.minimumBid) +
        ", please increase it and try again.");
    return false;
  }

  if (!incentru.userData.isSignedIn) {
    this.bidErrorMessage("You must be logged in to place a bid. Please log in and try again.");
    return false;
  }

  if (incentru.pageData.maxQuantity > 1 && params.quantity > incentru.pageData.maxQuantity) {
    this.bidErrorMessage("You must enter a quantity of less than " + incentru.pageData.maxQuantity + " units.");
    return false;
  }

  this.submitBidBtn.attr("disabled", "disabled");
  $.ajax({
    url: "/pins/" + incentru.pageData.pinId + "/bid",
    method: "POST",
    data: params,
    success: _.bind(this.bidSuccess, this),
    error: _.bind(this.bidError, this)
  });

  return false;
};

incentru.PinPage.bidSuccess = function(response) {
  this.submitBidBtn.removeAttr("disabled");
  if (response && response.success) {
    this.errorDiv.text("");
    this.successDiv.text("Successfully submitted bid. Refreshing page...");
    window.location.reload();
  } else {
    this.successDiv.text("Successfully submitted bid. Refreshing page...");
    this.bidError(response);
  }
};

incentru.PinPage.bidError = function(response) {
  this.submitBidBtn.removeAttr("disabled");
  alert(response.reason || "An error occurred. Please try again or contact us at info@incentru.com");
};

incentru.PinPage.bidErrorMessage = function(msg) {
  this.successDiv.text("");
  this.errorDiv.text(msg);
};

incentru.PinPage.updateFullPrice = function() {
  this.errorDiv.text("");
  var params = incentru.extra.serializeObject(this.form);
  var fullPrice = (params.price || 0) * (params.quantity || 1);
  this.form.find(".effective-price").text(incentru.extra.toTwoDecimals(fullPrice));
};
