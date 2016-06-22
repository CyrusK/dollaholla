var incentru = incentru || {};
incentru.extra = incentru.extra || {};

// http://stackoverflow.com/questions/1184624/convert-form-data-to-js-object-with-jquery
incentru.extra.serializeObject = function(form) {
  var o = {};
  var a = form.serializeArray();
  $.each(a, function() {
    if (o[this.name] !== undefined) {
      if (!o[this.name].push) {
        o[this.name] = [o[this.name]];
      }
      o[this.name].push(this.value || '');
    } else {
      o[this.name] = this.value || '';
    }
  });
  return o;
};

incentru.extra.toTwoDecimals = function(num) {
  return num.toFixed(2);
};
