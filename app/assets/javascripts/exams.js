$(document).ready(function() {
  function getTimeRemaining(endtime) {
    var t = Date.parse(endtime) - Date.parse(new Date());
    var seconds = Math.floor((t / 1000) % 60);
    var minutes = Math.floor((t / 1000 / 60) % 60);
    var hours = Math.floor((t / (1000 * 60 * 60)) % 24);
    return {
      'total': t,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds
    };
  }
  function initializeClock(id,endtime){
    var hoursSpan = $('#' + id + ' .hours');
    var minutesSpan = $('#' + id + ' .minutes');
    var secondsSpan = $('#' + id + ' .seconds');
    function updateClock(){
      var t = getTimeRemaining(endtime);
      hoursSpan.html(('0' + t.hours).slice(-2));
      minutesSpan.html(('0' + t.minutes).slice(-2));
      secondsSpan.html(('0' + t.seconds).slice(-2));
      if (t.total <= 0) {
        $("#form_example").submit();
        clearInterval(timeinterval);
      }
    }
    updateClock();
    setInterval(updateClock, 1000);
  }
  var duration = $('#duration').val();
  var deadline = new Date(Date.parse(new Date()) + duration * 1000);
  initializeClock('clockdiv', deadline);
});
