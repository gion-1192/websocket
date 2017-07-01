require "em-websocket"
require "securerandom"

module SocketServer
	def serverStart(host, port)
		@connections = []
		
		EM::WebSocket.start({:host => host, :port => port}) do | ws_conn |
			ws_conn.onopen do |msg|
				session_id = connection_start(ws_conn, msg)
				ws_conn.send(session_id)		
			end
			ws_conn.onmessage do |msg|
				connection_response(ws_conn, msg)
			end
			ws_conn.onclose do |msg|
				connection_close(ws_conn, msg)
			end
		end
	end

	protected
	
	def connection_start(ws_conn, msg)
		session_id = SecureRandom.hex
		@connections << {:id => session_id, :connection => ws_conn}

		return session_id
	end

	def connection_response(ws_conn, msg)
	end

	def connection_close(ws_conn, msg)
		session_id = msg
		@connections.each do |connection|
			id = connection[:id]
			@connections.delete_at(id) if onnection[:id] == session_id 
		end
	end
end
