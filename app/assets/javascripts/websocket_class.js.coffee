
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
    @events()
 
  events: () =>
    $('#button').on 'click', @requestCheckout
    $('.edit').each (index, element) =>
      target = $('#'+element.id)
      target.on 'focus', @requestLock
      target.on 'blur', @requestUnlock
      target.on 'keyup', @requestModify
    # サーバからの Push イベントのバインド
    # @dispatcher.bind 'controll', @controll
    @dispatcher.bind 'checkout', @checkout
    @dispatcher.bind 'lock', @lock
    @dispatcher.bind 'unlock', @unlock
    @dispatcher.bind 'modify', @modify

  requestCheckout: (event) =>
    message = {
      id: event.target.id,
      content: event.target.id
    }
    # FIX_ME: まとめようとしたら、バインドのときにうまくいかなかった。要調査 #1
    addCommonMessage message
    @dispatcher.trigger 'slide.checkout', message

  requestLock: (event) =>
    message = {
      id: event.target.id,
    }
    # FIX_ME: まとめようとしたら、バインドのときにうまくいかなかった。要調査 #1
    addCommonMessage message
    @dispatcher.trigger 'slide.lock', message

  requestUnlock: (event) =>
    message = {
      id: event.target.id,
    }
    # FIX_ME: まとめようとしたら、バインドのときにうまくいかなかった。要調査 #1
    addCommonMessage message
    @dispatcher.trigger 'slide.unlock', message

  requestModify: (event) =>
    message = {
      id: event.target.id,
      # ???: event.target を jQuery のオブジェクトにしてからしか内容とれない？
      content: $('#'+event.target.id).val()
    }
    # FIX_ME: まとめようとしたら、バインドのときにうまくいかなかった。要調査 #1
    addCommonMessage message
    console.log message
    @dispatcher.trigger 'slide.modify', message

  addCommonMessage = (message) ->
    # meta 情報を付与
    message['sender_name'] = $('#user_name').val()

  # サーバから push されたデータを反映
  checkout: (message) =>
    target = message2id(message)
    target.val(message['content']['content'])

  lock: (message) =>
    if (message.content.sender_name == $('#user_name').val()) 
      return
    target = message2id(message)
    target.attr('readonly', 'true')

  unlock: (message) =>
    target = message2id(message)
    target.attr('readonly', 'false')

  modify: (message) =>
    target = message2id(message)
    target.val(message['content']['content'])

  message2id = (message) ->
    $('#'+message['content']['id'])

$ ->
  window.websocketClass = new WebsocketClass('localhost:3000/websocket')
