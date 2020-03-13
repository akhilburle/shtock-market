from selenium import webdriver
import sys

driver = webdriver.Chrome('/Users/akhil/Downloads/chromedriver-1')
url = "https://finance.yahoo.com/chart/" + sys.argv[1]
driver.get(url)
driver.save_screenshot('pic.png')
driver.quit()
