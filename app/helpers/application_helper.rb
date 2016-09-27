module ApplicationHelper

  def is_this_product_a_target?(key)
    REDIS.sismember("lightinthebox-target", key)
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
