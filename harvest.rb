
require 'mechanize'
require 'csv'

url = 'https://wordpress.org/support/plugin/woocommerce-google-analytics-integration/reviews/'
output_file = 'google-analytics.csv'
extension_name = 'Google Analytics'
source = '.org Product Review'
focus_area = 'TBD'
shared_to_airtable = '.org review harvester'

agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'

page = agent.get(url)

CSV.open(output_file, 'wb') do |csv|
	csv << ["Feedback Received Date", "Feedback Description", "User's Quote", "Rating", "URLs", "Extension", "Source", "Focus Area", "Shared to Airtable by"]
	loop do
		# this is the table containing the reviews
		reviews_container = page.css('.bbp-body')
		# each review is in a row
		reviews_container.css('.topic').each do |review_row|
			# grab the URL for the review
			review_url = review_row.css('.bbp-topic-permalink').attr('href').value
			review_date = review_row.css('.bbp-topic-freshness a').attr('title').value[0...-11].strip
			
			puts page.title
			
			review_page = agent.get(review_url)
			puts review_page.title
			
			review = review_page.css('.entry-content')
				title = review.css('h1.page-title').text.strip
				rating = review.css('.wporg-ratings').attr('title').value[0...-15]
				body = review.css('.bbp-topic-content').text.gsub(/[\r\n]+/m, "\n").strip
			csv << [review_date, title, body, rating, review_url, extension_name, source, focus_area, shared_to_airtable]
		end

		next_link = page.link_with(:dom_class => 'next page-numbers')
		break unless next_link

		page = next_link.click
	end
end
