
#= require websocket_rails/main

# author: Ezura
# 参考:
# https://github.com/websocket-rails/websocket-rails
# http://ithijikata.hatenablog.com/entry/2014/03/06/021948
#
# WebsocketRails を扱う拡張クラス

class @WebsocketClass
  constructor: (url) ->
    # WebsocketRails::constructor: (@url, @use_websockets = true)
    @dispatcher = new WebSocketRails(url)
    @version = 0
    @resource_id = this.resourceId()
    # TODO: 型調べる
    @channel = @dispatcher.subscribe(@resource_id);
    console.log(@resource_id)

  resourceId: () ->
    parser = document.createElement('a');
    parser.href = location.href;
    paths = parser.pathname.split "/";
    paths[2]

  events: () =>
    $('.ws-object').each (index, element) =>
      target = $(element)
      target.on 'focus', @requestFocus
      target.on 'blur', @requestUnfocus
      target.on 'keyup', @requestModify
    # サーバからの Push イベントのバインド
    @dispatcher.bind 'controll', @controll
    @channel.bind 'checkout', @checkout
    @channel.bind 'state', @state
    @channel.bind 'modify', @modify
    # @channel.bind 'snapshot', @modify

  requestCheckout: (event) =>
    message = {
      id: $(event.target).attr("ws-object-id"),
      content: event.target.id
    }
    # FIX_ME: まとめようとしたら、バインドのときにうまくいかなかった。要調査 #1
    this.addCommonMessage message
    @dispatcher.trigger 'slide.checkout', message
    changeVersion(version)

  requestFocus: (event) =>
    message = {
      id: $(event.target).attr("ws-object-id"),
      state: 'focus'
    }
    # FIX_ME: まとめようとしたら、バインドのときにうまくいかなかった。要調査 #1
    this.addCommonMessage message
    @dispatcher.trigger 'user.state', message

  requestUnfocus: (event) =>
    message = {
      id: $(event.target).attr("ws-object-id"),
      state: 'unfocus'
    }
    # FIX_ME: まとめようとしたら、バインドのときにうまくいかなかった。要調査 #1
    this.addCommonMessage message
    @dispatcher.trigger 'user.state', message

  requestModify: (event) =>
    message = {
      id: $(event.target).attr("ws-object-id"),
      # ???: event.target を jQuery のオブジェクトにしてからしか内容とれない？
      content: $(event.target).val()
    }
    # FIX_ME: まとめようとしたら、バインドのときにうまくいかなかった。要調査 #1
    this.addCommonMessage message
    console.log message
    @dispatcher.trigger 'slide.modify', message

  addCommonMessage: (message) =>
    # meta 情報を付与
    message.sender_name = $('#user_name').val()
    message.resource_id = @resource_id

  controll: (message) =>
    target = message2id(message)

  # サーバから push されたデータを反映
  checkout: (message) =>
    target = message2id(message)
    target.val(message.content.content)

  state: (message) =>
    if (message.content.sender_name == $('#user_name').val())
      return
    target = message2id(message)
    action = message.content.state
    switch (action)
      when 'focus'
        target.addClass('focus');
        break
      when 'unfocus'
        target.removeClass("focus");
        break

  modify: (message) =>
    target = message2id(message)
    target.val(message.content.content)
    this.changeVersion(++@version)

  message2id = (message) ->
    console.log(message);
    $("[ws-object-id=" + message.content.id + "]")

  changeVersion: (version) =>
    # history.pushState(version, null, location.protocol+"://"+location.host+"/"+version)
