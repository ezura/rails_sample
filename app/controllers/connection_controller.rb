class ConnectionController < WebsocketRails::BaseController
    
    def initialize_session
        logger.debug("Session Initialized\n")
    end

=begin
    def checkout
      logger.debug("call checkout: #{message}")
      broadcast 'checkout', message
    end

    def lock
      logger.debug("call new_message: #{message}")
      broadcast 'controll', message
    end

    def unlock
      logger.debug("call new_message: #{message}")
      broadcast 'controll', message
    end

    def modify
      logger.debug("call new_message: #{message}")
      broadcast 'modify', message
    end
  
private
    def broadcast(method, content)
        message = {
          method: method,
          content: content
        }
        broadcast_message :update, message
    end
=end

    def checkout
      broadcast :checkout, message
    end

    def state
      broadcast :state, message
    end

    def modify
      broadcast :modify, message
    end
  
private
    def broadcast(method, content)
        message = {
          content: content
          # TODO: meta 情報を入れるかも
        }
        logger.debug("broadcast: #{message}")
        broadcast_message method, message
    end

end
