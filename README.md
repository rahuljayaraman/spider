## Spidy is a flexible module which can scrape information from any web-site

### Define a Spider

`spider = Spidy.new "Google"`

### Define different actions to perform

`visit = Action.new action_type: :visit, url: "http://google.com"
yank = Action.new action_type: :yank, div: "resultsStats", identifier_text: "Stats"`

### Add actions to the spiders web
`spider.add_to_web visit, yank`

### Make the spider crawl
`spider.crawl => # This will return required data`

