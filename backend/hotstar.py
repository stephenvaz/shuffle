
import time
from selenium import webdriver

options = webdriver.ChromeOptions()

# options.add_argument('--headless')
options.add_argument("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36")
options.add_argument('--log-level=3')
# options.add_experimental_option("excludeSwitches", ["enable-logging"])
options.add_experimental_option("excludeSwitches", ["enable-automation"])
#cloudflare bypass
options.add_experimental_option('useAutomationExtension', False) 
options.add_argument("--disable-blink-features=AutomationControlled")
# win
# d = webdriver.Chrome('D:\\Users\Stephen\Dev\Git\Python\chromedriver.exe', options=options)
# #mac
 
d = webdriver.Chrome(options=options)


def test1():
    l = []
    d.get('https://www.hotstar.com/in/tv/modern-family/8549/seasons/season-3/ss-3206')
    time.sleep(10)
    for i in range(24):
        link = d.find_element_by_xpath("/html/body/div/div/div/div[1]/div[2]/div/div/div/div/div/div["+str(i+1)+"]/div/a").get_attribute('href')
        l.append(link.replace('https://www.hotstar.com/in/tv/modern-family/8549/',''))
    print(l)


# test1()
#/html/body/div/div/div/div[1]/div[2]/div/div/div/div/div/div[1]/div/a ep1
#/html/body/div/div/div/div[1]/div[2]/div/div/div/div/div/div[2]/div/a ep2

# https://www.hotstar.com/in/tv/modern-family/8549/
def siliconValley2():
    f = open("data.txt", "a")
    ep = 9
    d.get("https://www.hotstar.com/in/tv/how-i-met-your-mother/8323")
    time.sleep(10)
    eps = [22,22,20,24,24,24,24,24,24]
    for i in range(ep):
        d.find_element_by_xpath("/html/body/div[1]/div/div/div[1]/div[2]/div[2]/div/div/div/div/div[3]/div/div/div/div[2]/div/div/div/div["+str(i+1)+"]/div/div/div/article/a/div[1]/div/div").click()
        time.sleep(10)
        
        for j in range(eps[i]):
            link = d.find_element_by_xpath("/html/body/div/div/div/div[1]/div[2]/div/div/div/div/div/div["+str(j+1)+"]/div/a").get_attribute('href')
            # print(link.replace('https://www.hotstar.com/in/tv/silicon-valley/8210/',''))
            f.write(f"'{link.replace('https://www.hotstar.com/in/tv/silicon-valley/8210/','')}', \n")
        print("write"+str(i+1))
        if i==5:
            f.close()
            break
        d.back()
        time.sleep(10)
def siliconValley():
    f = open("data.txt", "a")
    ep = 9
    d.get("https://www.hotstar.com/in/tv/how-i-met-your-mother/8323")
    time.sleep(10)
    eps = [22,22,20,24,24,24,24,24,24]
    for i in range(ep):
        d.find_elements_by_link_text("season-"+str(i+1)).click()
        time.sleep(10)
        
        for j in range(eps[i]):
            link = d.find_element_by_xpath("/html/body/div/div/div/div[1]/div[2]/div/div/div/div/div/div["+str(j+1)+"]/div/a").get_attribute('href')
            # print(link.replace('https://www.hotstar.com/in/tv/silicon-valley/8210/',''))
            f.write(f"'{link.replace('https://www.hotstar.com/in/tv/silicon-valley/8210/','')}', \n")
        print("write"+str(i+1))
        if i==5:
            f.close()
            break
        d.back()
        time.sleep(10)

    
# siliconValley()

#/html/body/div[1]/div/div/div[1]/div[2]/div[2]/div/div/div/div/div[3]/div/div/div/div[2]/div/div/div/div[1]/div/div/div/article/a/div[1]/div/div
#/html/body/div[1]/div/div/div[1]/div[2]/div[2]/div/div/div/div/div[3]/div/div/div/div[2]/div/div/div/div[2]/div/div/div/article/a/div[1]/div/div
# siliconValley()
#/html/body/div/div/div/div[1]/div[2]/div/div/div/div/div/div[1]/div/a ep1
#/html/body/div/div/div/div[1]/div[2]/div/div/div/div/div/div[2]/div/a ep2

#/html/body/div[1]/div/div/div[1]/div[2]/div/div/div/div/div/div[1]/div/a
def fuckUP():
    f = open("data.txt", "r")
    f2 = open("data2.txt", "a")
    for line in f:
        f2.write(f"{line}")

# fuckUP()

def general():
    f = open("data.txt", "a")
    show_main_link = "https://www.hotstar.com/in/tv/how-i-met-your-mother/8323"
    d.get(show_main_link)
    time.sleep(15)
    eps = []
    seasons = int(d.find_element_by_xpath("/html/body/div[1]/div/div/div[1]/div[2]/div[1]/div/div[3]/div[2]/div/div[2]/div[2]/div/span/span[1]").text.replace('Seasons',''))
    for i in range(seasons):
        try:
            elem = (d.find_element_by_xpath('//*[@id="app"]/div/div/div[1]/div[2]/div[2]/div/div/div/div/div[4]/div/div/div/div[2]/div/div/div/div['+str(i+1)+']/div/div/div/article/a/div[2]/div/div/span[3]').text).replace(' Episodes','')
            # print(elem)
            eps.append(int(elem))
        except:
            d.find_element_by_xpath("/html/body/div[1]/div/div/div[1]/div[2]/div[2]/div/div/div/div/div[1]/div/div/div/div[2]/i").click
            i-=1
    print(eps)
    
    for i in range(seasons):
        d.find_element_by_xpath("/html/body/div[1]/div/div/div[1]/div[2]/div[2]/div/div/div/div/div[3]/div/div/div/div[2]/div/div/div/div["+str(i+1)+"]/div/div/div/article/a/div[1]/div/div").click()
        time.sleep(10)
        for j in range(eps[i]):
            link = d.find_element_by_xpath("/html/body/div/div/div/div[1]/div[2]/div/div/div/div/div/div["+str(j+1)+"]/div/a").get_attribute('href')
            
            f.write(f"'{link.replace(show_main_link,'')}', \n")
        print("Season"+str(i+1))
        if i==seasons-1:
            f.close()
            d.quit()
            break

        d.back()
        time.sleep(10)
        #//*[@id="app"]/div/div/div[1]/div[2]/div[2]/div/div/div/div/div[4]/div/div/div/div[2]/div/div/div/div[1]/div/div/div/article/a/div[2]/div/div/span[3]
        #//*[@id="app"]/div/div/div[1]/div[2]/div[2]/div/div/div/div/div[4]/div/div/div/div[2]/div/div/div/div[2]/div/div/div/article/a/div[2]/div/div/span[3]

# general()
# /html/body/div[1]/div/div/div[1]/div[2]/div[1]/div/div[3]/div[2]/div/div[2]/div[1]/div/span/span[1]

#/html/body/div[1]/div/div/div[1]/div[2]/div[2]/div/div/div/div/div[4]/div/div/div/div[2]/div/div/div/div[1]/div/div/div/article/a/div[2]/div/div/span[3]
#/html/body/div[1]/div/div/div[1]/div[2]/div[2]/div/div/div/div/div[4]/div/div/div/div[2]/div/div/div/div[2]/div/div/div/article/a/div[2]/div/div/span[3]
        #/html/body/div[1]/div/div/div[1]/div[2]/div[2]/div/div/div/div/div[4]/div/div/div/div[2]/div/div/div/div[1]/div/div/div/article/a/div[2]/div/div/span[1]
        #/html/body/div[1]/div/div/div[1]/div[2]/div[2]/div/div/div/div/div[4]/div/div/div/div[2]/div/div/div/div[2]/div/div/div/article/a/div[2]/div/div/span[1]

def Google():
    d.get("https://www.google.com/search?q=big+bang+theory+season+1&sxsrf=ALiCzsYu6IFUip0-Dfk0Bsfm4IK2xXhHfA%3A1652719637788&source=hp&ei=FYCCYoPXLYWCoASfr6qIAg&iflsig=AJiK0e8AAAAAYoKOJVTPBgX_QZHbOcMMCEyqJaIx7YVU&oq=big+b&gs_lcp=Cgdnd3Mtd2l6EAEYATIKCC4QsQMQ1AIQQzIECAAQQzIECAAQQzIECAAQQzIOCC4QgAQQsQMQxwEQowIyEAguEIAEELEDEMcBEKMCEAoyBAgAEEMyCAgAEIAEEMkDMgUIABCSAzIFCAAQkgM6BAgjECc6BwguENQCEEM6BAguEEM6CAgAELEDEIMBOggIABCABBCxAzoLCAAQgAQQsQMQgwE6BQgAEIAEOgoIABCABBCHAhAUOhEILhCABBCxAxCDARDHARCjAlAAWPMHYKMRaABwAHgAgAHMBIgBnA6SAQkwLjIuNC0xLjKYAQCgAQE&sclient=gws-wiz")
    time.sleep(5)
    d.find_element_by_xpath('/html/body/div[7]/div/div[10]/div[2]/div[2]/div[2]/div/div/div/div/div[2]/div/div[3]/div/div/div/div/div/div/div[12]/div/div/div/div[3]/div[2]/div/div/div[2]/div/div/div/div/g-expandable-container/div/g-expandable-content[16]/span/g-more-link/div').click()
    time.sleep(2)


#<a href="/detail/0RV6K7KSNW4S9LI3UDGPXLLYRQ/ref=atv_dp_btf_el_prime_sd_tv_resume_t1ADAAAAAA0wg0?autoplay=1&amp;t=0" aria-label="Watch episode 2, The Deception Verification" class="_1b1ljL _3JtJT0" tabindex="0"><span class="_2UD9Ud _2tr-LP"><span class="Gpyvwj _18GlHj _1aRTKf"></span></span><span class="_2eDsro"><div class="js-episode-title-name _2t8khh"><span dir="auto"> <!-- -->2. The Deception Verification<!-- --> </span></div></span></a>