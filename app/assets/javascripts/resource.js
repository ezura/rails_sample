"use strict"

var Resource;

// TODO: 過去を指定したときにサーバでリソースを作るか、クライアントにlogを投げて作らせるか
Resource = function(info) {
  // FIXME: もっと良い方法ないか
    this.document_id = ("document_id" in info) ? info.document_id : info.id;
    this.version = info.version;
    this.contents = $.parseJSON(info.contents);
    this.meta = info.meta;
    this.version_name = info.version_name;
    this.tmp =  ("tmp" in info) ? info.tmp : null;

}

Resource.prototype = {
  generate: function() {
    for(var objectId in this.contents) {
      $('<textarea class="ws-object" ws-object-id="' + objectId + '">' + this.contents[objectId] + "</textarea>").appendTo('#contents');
    }
  },
  patch: function(info) {
    // TODO: log からの情報に従って パッチを当てる (実装によっては進むか戻るかによって処理違なるはず)
    // !!!: 優先順位的に高くない
  }
}
