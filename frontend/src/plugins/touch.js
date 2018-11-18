//     Формирует события которые распростроняются вниз от document
//     "onTouchTab"
//     "onTouchLongTab"
//     "onTouchLeft"
//     "onTouchRight"
//     "onTouchTop"
//     "onTouchBottom"

const Touch = {
  install(Vue, options) {
    var onTouchTab = new Event("onTouchTab", {
      bubbles: true,
      cancelable: true
    });
    var onTouchLongTab = new Event("onTouchLongTab", {
      bubbles: true,
      cancelable: true
    });
    var onTouchRight = new Event("onTouchRight", {
      bubbles: true,
      cancelable: true
    });
    var onTouchLeft = new Event("onTouchLeft", {
      bubbles: true,
      cancelable: true
    });
    var onTouchTop = new Event("onTouchTop", {
      bubbles: true,
      cancelable: true
    });
    var onTouchBottom = new Event("onTouchBottom", {
      bubbles: true,
      cancelable: true
    });
    // короткое нажатие
    document.addEventListener(
      "touchstart",
      function(event) {
        if (event.targetTouches.length == 1) {
          // var myclick = event.targetTouches[0];

          event.target.dispatchEvent(onTouchTab);
        }
      },
      false
    );

    // длительное нажатие
    var ldelay;
    var betw = {};
    document.addEventListener(
      "touchstart",
      function(event) {
        ldelay = new Date();
        betw.x = event.changedTouches[0].pageX;
        betw.y = event.changedTouches[0].pageY;
      },
      false
    );
    /*Ловим отпускание пальца*/
    document.addEventListener(
      "touchend",
      function(event) {
        var pdelay = new Date();
        if (
          event.changedTouches[0].pageX == betw.x &&
          event.changedTouches[0].pageY == betw.y &&
          pdelay.getTime() - ldelay.getTime() > 800
        ) {
          event.target.dispatchEvent(onTouchLongTab);
        }
      },
      false
    );

    //листания
    var initialPoint;
    var finalPoint;
    document.addEventListener(
      "touchstart",
      function(event) {
        initialPoint = event.changedTouches[0];
      },
      false
    );
    document.addEventListener(
      "touchend",
      function(event) {
        finalPoint = event.changedTouches[0];
        var xAbs = Math.abs(initialPoint.pageX - finalPoint.pageX);
        var yAbs = Math.abs(initialPoint.pageY - finalPoint.pageY);
        if (xAbs > 20 || yAbs > 20) {
          if (xAbs > yAbs) {
            if (finalPoint.pageX < initialPoint.pageX) {
              event.target.dispatchEvent(onTouchLeft);
            } else {
              event.target.dispatchEvent(onTouchRight);
            }
          } else {
            if (finalPoint.pageY < initialPoint.pageY) {
              event.target.dispatchEvent(onTouchTop);
            } else {
              event.target.dispatchEvent(onTouchBottom);
            }
          }
        }
      },
      false
    );
  }
};
export default Touch;
