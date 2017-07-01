require "redis"
require "rmagick"
redis = Redis.new

image = Magick::ImageList.new("63134826_p0.png")
i = image[0]
redis.set "image", i

img = redis.get "image"
img.write("test2.png")

redis.flushdb
