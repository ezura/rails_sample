var RestfulWebSocket

(function(){
  "use strict";

  RestfulWebSocket = function(resource_info) {
    this.resource = new Resource(resource_info);
    this.websocket = new WebsocketClass('localhost:3100/websocket');

    this.resource.generate();
    this.websocket.events();
  }
})();
