class AppBestSellProductsController < ApplicationController

  def index
    date = params[:the_date] || Time.now.to_date
    num = params[:num] || 100
    if params[:type].to_s == "monthly"
      date = date.is_a?(String) ? (Date.parse(date)).beginning_of_month.to_date : date.beginning_of_month.to_date
      quantity = params[:quantity] || 100
      @productsale =  MonthlyProductSale.fetch_statistic({the_date: date, num: num.to_i, orderd: "quantity DESC", quantity: quantity.to_i })
    else
      quantity = params[:quantity] || 10
      @productsale =  DailyProductSale.fetch_statistic({the_date: date, num: num.to_i, orderd: "quantity DESC", quantity: quantity.to_i })
    end
  end

end
