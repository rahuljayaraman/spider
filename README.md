## Build a flexible module which can scrape information from any web-site

### Define a Spider

        :::ruby
        spider = ScrapingSpider.new "Google"

### Give the spider new directives

        :::ruby
        visit = Action.new action_type: :visit, url: "http://google.com"
        fill_form = Action.new action_type: :fill_form, field_name: "q", text: "Apple"
        yank = Action.new action_type: :yank, div: "resultStats"

### Add the directives to the spider's web

        :::ruby
        spider.add_to_web visit, fill_form, yank

### Make the spider crawl

        :::ruby
        spider.crawl => # This will return required data

