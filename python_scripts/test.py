import requests
from bs4 import BeautifulSoup
import pandas as pd

start_url = ''

page_html = requests.get(start_url)

soup = BeautifulSoup(page_html.text)

with open('page.html', 'w') as file:
    file.write(soup.prettify())