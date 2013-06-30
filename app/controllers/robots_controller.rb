require 'scraping_spider'
require 'instruction'

class RobotsController < ApplicationController
  def gogogo
    if params[:visit].present?
      begin
        instructions = []
        visit = params.fetch :visit
        instructions << Instruction.new(action: :visit_site, url: visit)
        if params[:clicks].present? && !params[:clicks].empty?
          clicks = params.fetch :clicks
          clicks.each do |key, value|
            click = value.fetch :click
            instructions << Instruction.new(action: :click, link: click) unless click.blank?
          end
        end
        if params[:forms].present? && !params[:forms].empty?
          forms = params.fetch :forms
          forms.each do |key, value|
            field_name = value.fetch :field_name
            field_content = value.fetch :field_content
            instructions << Instruction.new(action: :fill_form, fields: [{field_name: field_name, text: field_content}]) unless field_name.blank?
          end
        end
        yank = params.fetch :yank
        instructions << Instruction.new(action: :yank_data, css: yank)
        spider = ScrapingSpider.new "Fetch"
        spider.feed_instructions *instructions
        @results = spider.crawl
      rescue Capybara::Poltergeist::TimeoutError
        @results = "Request Timed out"
      rescue DataNotFound
        @results = "Data not found"
      end
    end
  end
end
