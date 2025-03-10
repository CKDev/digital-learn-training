$(function() {
  CharacterLimit.init();
});

var CharacterLimit = (function($) {
  return {
    init: function() {
      $("*[maxlength]").each(updateText);
      $("body").on("keyup", "*[maxlength]", updateText);
    }
  };

  function updateText() {
    var characterLimit = $(this).attr("maxlength");
    var characterCount = $(this).val().length;
    $(this).siblings(".character-limit").text(characterLimit - characterCount + " characters remaining");
  }

})(jQuery);
