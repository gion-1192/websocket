require 'redis'
require './webSocketServer.rb'

class ChatServer
	include SocketServer

	def initialize
		@redis = Redis.new
	end

	def serverStart(host, port)
		super(host, port)
	end

	def connection_start(ws_conn, message)
		room_id = message
		session_id = SecureRandom.hex

		@connectons[room_id] << {id: session_id, connection: ws_conn}
		
		return session_id
 		#@redis.lpush 1,"{id:4, name:test2}"
	end

	def connection_response(ws_conn, message)
		
	end

	def connection_close(ws_conn, message)

	end

end
ChatServer.new.serverStart('localhost', 60000)
