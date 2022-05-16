
from random import random, randrange
import time
from selenium import webdriver

options = webdriver.ChromeOptions()

# options.add_argument('--headless')
options.add_argument("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36")
options.add_argument('--log-level=3')
options.add_experimental_option("excludeSwitches", ["enable-logging"])
options.add_experimental_option("excludeSwitches", ["enable-automation"])
#cloudflare bypass
options.add_experimental_option('useAutomationExtension', False) 
options.add_argument("--disable-blink-features=AutomationControlled")
# win
# d = webdriver.Chrome('D:\\Users\Stephen\Dev\Git\Python\chromedriver.exe', options=options)
# #mac
 
d = webdriver.Chrome(options=options)

def test():
    s = 12
    eps = [17,23,23,24,24,24,24,24,24,24,24,24]
    f = open("data.txt", "w")
    for i in range(s):
        for j in range(eps[i]):
            d.get("https://www.google.com/search?q=the+big+bang+theory+season+"+str(i+1)+"+episode+"+str(j+1)+"")
            try:
                d.find_element_by_xpath("/html/body/div[2]/div[3]/div[2]/div/label")
                print("PROBLEMO")
                j-=1
                time.sleep(25)
                
                #/html/body/div[2]/div[3]/div[2]/div/label
            except:
                try:
                    testVar = d.find_element_by_xpath("/html/body/div[7]/div/div[11]/div[2]/div/div/div[2]/div/div[4]/div/div/div/div/div[2]/div/div/div/div/div/div/div[2]/div[1]/a").get_attribute("href")
                except:
                    try:
                        testVar = d.find_element_by_xpath("/html/body/div[7]/div/div[10]/div[3]/div[2]/div/div/div[2]/div/div[2]/div/div/div/a").get_attribute("href")
                    except:
                        try:
                            testVar = d.find_element_by_xpath("/html/body/div[7]/div/div[10]/div[3]/div[2]/div/div/div[2]/div/div/div/div/div[1]/div[1]/a").get_attribute("href")
                        except:
                            testVar = "None"
                            print(f"s{i}e{j} missing")
                time.sleep(randrange(0,3))
                testVar = testVar.replace("https://www.primevideo.com/dp/", "")
                f.write(f"'{testVar}'\n")
        time.sleep(randrange(1,10))
test()

#/html/body/div[7]/div/div[10]/div[3]/div[2]/div/div/div[2]/div/div[2]/div/div/div/a