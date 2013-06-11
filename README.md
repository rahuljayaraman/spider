## Build a flexible module which can scrape information from any web-site

### Define a Spider

        spider = ScrapingSpider.new "Google"

### Give the spider new directives

        visit = Action.new action_type: :visit, url: "http://google.com"
        form = Action.new action_type: :form, field_name: "q", text: "Apple"
        yank = Action.new action_type: :yank, div: "resultsStats"

### Add the directives to the spider's web

        spider.add_to_web visit, yank

### Make the spider crawl

        spider.crawl => # This will return required data

