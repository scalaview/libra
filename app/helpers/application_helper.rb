module ApplicationHelper

  def is_this_product_a_target?(key)
    REDIS.sismember("lightinthebox-target", key)
  end

  def brand_clean(name)
    _name = name
    ["BOB®", "VDL®", "Fei Beauty®", "Danni®", "UOUO®", "Keqi ®", "DANNI®", "MSQ®", "New NOVO®", "New LIDEAL®", "Fenlin ®", "YCID®", "New Clever Cat®", "New Love ALOBON®", "Midnight Cool®", "Girl Zone®",
      "Keqi ®", "Sedona®", "vela.yue®", "Make-up For You®", "Maycheer®", "Y.CID®", "Fenlin ® NBR", "MFN®", "By Nanda®", "Ningmei®", "®"].each do |brand|
      _name = _name.gsub(/#{brand}/i, '')
    end
    _name.strip
  end

end
