require 'httparty'
require 'nokogiri'

url = 'https://tns4lpgmziiypnxxzel5ss5nyu0nftol.lambda-url.us-east-1.on.aws/challenge'
response = HTTParty.get(url)

if response.code == 200
    html_text = Nokogiri::HTML(response.body)

    new_url = ""

    html_text.css('code').each do |code_tag|
    if code_tag['data-class']&.start_with?('23')
      # Find the <div> tag within the <code> tag with 'data-tag' ending in "93"
      div_tag = code_tag.at_css('div[data-tag$="93"]')
      if div_tag
        # Find the <span> tag within the <div> tag with 'data-id' containing "21"
        span_tag = div_tag.at_css('span[data-id*="21"]')
        if span_tag
          # Find the <i> tag within the <span> tag
          i_tag = span_tag.at_css('i')
          if i_tag
            # Append the text of the <i> tag to the URL segments
            url_segments += i_tag.text
          end
        end
      end
    end
  end

  puts "New URL: #{new_url}"
else
    puts 'Connection failed'
end