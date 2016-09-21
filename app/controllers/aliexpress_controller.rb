class AliexpressController < ApplicationController

  def export
    @spus = Product.where(id: params[:ids]).map(&:standard_product)
    filename = "products-#{Time.now.to_i}.xls"

    respond_to do |format|
      format.xls {
        headers["Content-Disposition"] = "attachment; filename=\"#{filename}\""
      }
    end
  end

end