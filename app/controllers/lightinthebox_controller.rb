class LightintheboxController < ApplicationController

  def index
    @products = REDIS.smembers("lightinthebox").map do |url|
      SampleProduct.new REDIS.hgetall(url).merge({url: url, images: images(url)})
    end
  end

  private

  def images(url)
    REDIS.lrange("imgs|#{url}", 0, -1)
  end
end
