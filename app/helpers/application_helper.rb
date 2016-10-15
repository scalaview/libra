module ApplicationHelper

  def is_this_product_a_target?(key)
    REDIS.sismember("lightinthebox-target", key)
  end

  def is_aliexpress_target?(key)
    REDIS.zscore("aliexpress:target", key)
  end

  def diy_pagination(con, start, per, total)
    next_start = (start+per)
    pre_start = (start - per)
    html = "<ul class='pagination'>"
    if pre_start >= 0
      html = html + "<li><a href='/aliexpress-products?k=#{con}&s=#{pre_start}'>上一页</a></li>"
    end
    if next_start < total
      html = html + "<li><a href='/aliexpress-products?k=#{con}&s=#{next_start}'>下一页</a></li>"
    end
    (html + "</ul>").html_safe
  end

  def brand_clean(name)
    _name = name
    ["BOB®", "VDL®", "Fei Beauty®", "Danni®", "UOUO®", "Keqi ®", "DANNI®", "MSQ®", "New NOVO®", "New LIDEAL®", "Fenlin ®", "YCID®", "New Clever Cat®", "New Love ALOBON®", "Midnight Cool®", "Girl Zone®",
      "Keqi ®", "Sedona®", "vela.yue®", "Make-up For You®", "Maycheer®", "Y.CID®", "Fenlin ® NBR", "MFN®", "By Nanda®", "Ningmei®", "®"].each do |brand|
      _name = _name.gsub(/#{brand}/i, '') if _name.present?
    end
    _name = _name.gsub(/\d|#/, "") if _name.present?
    _name.try(:strip).to_s
  end

  def skuarray
    {"skuArray" => [{"价格" => "1", "库存" => "999", "商家编码" => ""}]}.to_json
  end

  def dynamic
    return <<EOF
;2;;201512802;;
EOF
  end
end
