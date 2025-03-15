class RobotsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def robots
    respond_to :text

    @sitemap = Rails.application.routes.url_helpers.respond_to?(:sitemap_url) ? sitemap_url(format: :xml) : nil
    @crawling_enabled = RadConfig.allow_crawling? &&
                        (RadConfig.always_crawl? || request.subdomain.in?(RadConfig.crawlable_subdomains))
  end
end
