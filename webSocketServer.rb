require "em-websocket"

module SocketServer
	def serverStart(host, port)

		@channel = EM::Channel.new
		
		EM::WebSocket.start({:host => host, :port => port}) do | ws_conn |
			ws_conn.onopen do
				sid = @channel.subscribe do |msg|
					msg_response(ws_conn, msg, sid);
				end
				ws_conn.onmessage do |msg|
					msg_request(msg, sid)
				end
				ws_conn.onclose do |msg|
					msg_close(msg, sid)
					@channel.unsubscribe(sid)
				end
			end
		end
	end

	protected

	def msg_request(msg)
		@channel.push msg
	end

	def msg_response(ws_conn, msg, sid)
		ws_conn.send(msg)
	end

	def msg_close(msg)
		p msg
	end
end
