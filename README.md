# WordPress.org Plugin Reviews

A small Ruby script to harvest the reviews from wordpress.org for a given plugin, and write them to a csv file

This script makes use of the [mechanize](https://rubygems.org/gems/mechanize/versions/2.9.1?locale=en) gem to crawl the user reviews submitted on WordPress.org and to download them to a CSV file.

To run:

1. Clone repository
2. Make sure you have rbenv installed `brew install rbenv`
3. `rbenv install 3.1.2`
4. `cd dotorg_reviews`
5. `bundle install`
6. `ruby harvest.rb`

If you want to point it at a different plugin, just edit the variables in the top of `harvest.rb`:

`url` -> Base URL on wordpress.org for the reviews
`output_file` -> Name of the CSV to create (will be created in the same folder where the script is run)
`extension_name` -> A user readable name for the extension
`source`, `focus_area` and `shared_to_airtable` can all be changed accordingly (or left blank).
