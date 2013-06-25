require 'scraping_spider'
require 'instruction'

class RobotsController < ApplicationController
  def gogogo
    if params[:visit].present?
      begin
        instructions = []
        visit = params.fetch :visit
        instructions << Instruction.new(action: :visit_site, url: visit)
        click = params.fetch :click
        instructions << Instruction.new(action: :click, link: click) unless click.blank?
        field_name = params.fetch :field_name
        field_content = params.fetch :field_content
        instructions << Instruction.new(action: :fill_form, fields: [{field_name: field_name, text: field_content}]) unless field_name.blank?
        yank = params.fetch :yank
        instructions << Instruction.new(action: :yank_data, css: yank)
        spider = ScrapingSpider.new "Fetch"
        spider.feed_instructions *instructions
        @results = spider.crawl
      rescue Capybara::Poltergeist::TimeoutError
        @results = "Request Timed out"
      end
    end
  end
end
