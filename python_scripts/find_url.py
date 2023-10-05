"""Script to decode hidden link"""

import requests
from bs4 import BeautifulSoup

# Fetch the webpage content
url = 'https://tns4lpgmziiypnxxzel5ss5nyu0nftol.lambda-url.us-east-1.on.aws/challenge'
response = requests.get(url)

# Check to make sure the request was successful
if response.status_code == 200:
    # Parse the HTML content
    soup = BeautifulSoup(response.text, 'html.parser')

    # Initialize an empty string to store the URL segments
    url_segments = ""

    for code_tag in soup.find_all('code', {'data-class': lambda c: c and c.startswith('23')}):
        div_tag = code_tag.find('div', {'data-tag': lambda x: x and x.endswith('93')})
        if div_tag:
            span_tag = div_tag.find('span', {'data-id': lambda x: x and "21" in x})
            if span_tag:
                i_tag = span_tag.find('i')
                if i_tag:
                    # Append value attribute of the <i> tag to the URL segments
                    url_segments += i_tag.get('value')

    print(f"New URL: {url_segments}")
else:
    print(f"Failed to retrieve the webpage. Status code: {response.status_code}")
