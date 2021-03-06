class LightintheboxController < ApplicationController

  def index
    key = params[:set] || 'lightinthebox'
    @products = REDIS.smembers(key).map do |url|
      attributes=REDIS.hgetall(url)
      if attributes.present?
        SampleProduct.new(attributes.merge({url: url, images: images(url)}))
      else
      end
    end.compact
  end

  def toggle
    if params[:url].present?
      if REDIS.sismember("lightinthebox-target", params[:url]) && REDIS.srem("lightinthebox-target", params[:url])
        render json: { err: 0, msg: "remove success"  }
      elsif REDIS.sadd("lightinthebox-target", params[:url])
        render json: { err: 0, msg: "add success"  }
      else
        render json: { err: 1, msg: "operation failed"  }
      end
    end
  end

  private

  def images(url)
    REDIS.lrange("imgs|#{url}", 0, -1)
  end
end
