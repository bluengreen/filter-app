class CategoriesController < ApplicationController
  def index
    @title = "#{Setting.site_name}"

    @categories = Category.all.order('name')

    count = (Setting.get('trend_min_sources_count') || 4).to_i
    @trends = Trends::Trend.top_of_n_days(60.days.ago, count)
  end

  def show
    @category = Category.find_by!(slug: params[:id])
    sql = @category.news_items.
      visible.
      joins(:source).
      where(sources: { type: 'FeedSource' }).
      includes(:source).
      paginate(page: page, per_page: 12)

    @news_items = case params[:sort]
                  when 'recent'
                    sql.show_page
                  else # best
                    sql.top_percent_per_week(6.months.ago, 0.35, 50)
                  end

    @title = "All News in category #{@category.name}"

    @month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
  end

  private

  def page
    if params[:page] && params[:page].to_s[/\A\d+\z/]
      params[:page].to_i
    else
      1
    end
  end
end
