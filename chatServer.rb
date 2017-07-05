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

	def msg_request(msg, sid)
		if (@redis.get sid).nil?
			@redis.set sid,msg
			@redis.sadd msg,sid
		end

		@channel.push msg
	end

	def msg_response(ws_conn, msg, sid)
		(@redis.smembers msg).each do |id|
			if id.to_i == sid then
				ws_conn.send(msg)
				break		
			end
		end	
	end

	def msg_close(msg, sid)
		room_id = @redis.get sid

		@redis.del sid
		@redis.srem room_id, sid

		p "connection close!"
	end
end
ChatServer.new.serverStart('localhost', 60000)
