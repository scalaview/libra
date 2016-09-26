class AliexpressController < ApplicationController

  def export
    @spus = params[:urls].map do |url|
      SampleProduct.new REDIS.hgetall(url).merge({url: url, images: images(url)})
    end.compact
    filename = "products-#{Time.now.to_i}.xls"

    respond_to do |format|
      format.xls {
        headers["Content-Disposition"] = "attachment; filename=\"#{filename}\""
      }
    end
  end

  private
  def images(url)
    REDIS.lrange("imgs|#{url}", 0, -1)
  end
end