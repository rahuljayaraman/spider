## Build a flexible module which can scrape information from any web-site

### Define a Spider

        spider = ScrapingSpider.new "Google"

### Give the spider new directives

        visit_site = Action.new action_type: :visit_site, url: "http://google.com"
        fill_form = Action.new action_type: :fill_form, field_name: "q", text: "Apple"
        yank_data = Action.new action_type: :yank_data, div: "resultStats"

### Add the directives to the spider's web

        spider.add_to_web visit_site, fill_form, yank_data

### Make the spider crawl

        spider.crawl => # This will return required data

