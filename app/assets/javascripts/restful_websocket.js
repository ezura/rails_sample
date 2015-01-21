var RestfulWebSocket

(function(){
  "use strict";

  RestfulWebSocket = function(resource_info) {
    this.resource = new Resource(resource_info);
    this.websocket = new WebsocketClass('localhost:3100/websocket');

    this.resource.generate();
    this.websocket.events();

    this.addResourcesLink();
  }

  RestfulWebSocket.prototype.addResourcesLink = function() {
    var elmLink = document.createElement('div'); //resource-link
    var elmPrev = document.createElement('a');
    var elmNext = document.createElement('a');

    document.body.insertBefore(elmLink, document.body.firstChild);
    elmLink.appendChild(elmPrev);
    elmLink.appendChild(elmNext);

    elmLink.id = 'resource-link';
    elmPrev.id = 'restful-ws-prev';
    elmNext.id = 'restful-ws-next';

    elmPrev.innerHTML = '&lt; Previous ';
    elmNext.innerHTML = 'Next &gt;';

    elmPrev.addEventListener("click", function(e) {
      // TODO: ws で差分とってきて反映
      history.pushState(null, null, $("head>link[rel='prev']").attr("href"));
      e.preventDefault();
    }, false);

    elmNext.addEventListener("click", function(e) {
      // TODO: ws で差分とってきて反映
      history.pushState(null, null, $("head>link[rel='next']").attr("href"));
      e.preventDefault();
    }, false);
  }
})();
