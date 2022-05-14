
import time
from selenium import webdriver

options = webdriver.ChromeOptions()

options.add_argument('--headless')
options.add_argument("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36")
options.add_argument('--log-level=3')
# options.add_experimental_option("excludeSwitches", ["enable-logging"])
options.add_experimental_option("excludeSwitches", ["enable-automation"])
#cloudflare bypass
options.add_experimental_option('useAutomationExtension', False) 
options.add_argument("--disable-blink-features=AutomationControlled")
#win
# d = webdriver.Chrome('D:\\Users\Stephen\Dev\Git\Python\chromedriver.exe', options=options,service_log_path='NUL')
#mac
d = webdriver.Chrome(options=options,service_log_path='NUL')


def test1():
    l = []
    d.get('https://www.hotstar.com/in/tv/modern-family/8549/seasons/season-1/ss-3203')
    time.sleep(5)
    for i in range(24):
        link = d.find_element_by_xpath("/html/body/div/div/div/div[1]/div[2]/div/div/div/div/div/div["+str(i+1)+"]/div/a").get_attribute('href')
        l.append(link.replace('https://www.hotstar.com/in/tv/modern-family/8549/',''))
    print(l)


test1()
#/html/body/div/div/div/div[1]/div[2]/div/div/div/div/div/div[1]/div/a ep1
#/html/body/div/div/div/div[1]/div[2]/div/div/div/div/div/div[2]/div/a ep2

# https://www.hotstar.com/in/tv/modern-family/8549/