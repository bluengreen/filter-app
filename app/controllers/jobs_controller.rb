class JobsController < ApplicationController
  def index
    response = Rails.cache.fetch("#{Setting.jobs_url}", expires_in: 10.minutes) {
      HTTParty.get(Setting.jobs_url)['jobs']
    }
    @jobs = response.shuffle
    render layout: false
  end
end
