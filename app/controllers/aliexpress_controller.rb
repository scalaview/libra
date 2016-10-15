class AliexpressController < ApplicationController

  def products
    @con = params[:k] || "sortresult"
    @start = params[:s].present? ? params[:s].to_i : 0
    @per = params[:per].present? ? params[:per].to_i : 30
    @end = @start + @per
    @total = REDIS.zcard("aliexpress:#{@con}")

    @keywords = REDIS.zrange("aliexpress:#{@con}", @start, @end).map do |key|
      _products = REDIS.lrange("aliexpress:products:#{key}", 0, -1).map do |pj|
        SampleProduct.new JSON.parse(json_string_format(pj))
      end
      SimpleObject.new REDIS.hgetall("aliexpress:keyword:#{key}").merge({products: _products})
    end
  end

  def toggle
    if params[:keyword].present?
      if REDIS.zscore("aliexpress:target", params[:keyword]) && REDIS.zrem("aliexpress:target", params[:keyword])
        render json: { err: 0, msg: "remove success"  }
      elsif REDIS.zadd("aliexpress:target", params[:sort].to_f, params[:keyword])
        render json: { err: 0, msg: "add success"  }
      else
        render json: { err: 1, msg: "operation failed"  }
      end
    end
  end

  def export
    @spus = params[:urls].map do |url|
      SampleProduct.new REDIS.hgetall(url).merge({url: url, images: images(url) })
    end.compact
    filename = "products-#{Time.now.to_i}.xls"
    respond_to do |format|
      format.xls {
        headers["Content-Disposition"] = "attachment; filename=\"#{filename}\""
      }
    end
  end

  private

  def json_string_format(str)
    start = str.index("title': ") + 9
    _end = (str.index("\", 'order_number") || str.index("', 'order_number"))-1
    title = str[start.._end]
    str.gsub(title, title.gsub("'", "")).gsub("'", '"')
  end

  def images(url)
    REDIS.lrange("imgs|#{url}", 0, -1).reverse
  end
end