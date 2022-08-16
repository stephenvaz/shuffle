from bs4 import BeautifulSoup
import requests
def silicon():
    f = open("siliconS4.txt", 'w')
    with open('D:\Code\Github codes\web-scrap\Stephun\siliconS4.html', 'r') as html_file:
        content = html_file.read()

        soup = BeautifulSoup(content, 'lxml')
        links = soup.find_all('div', class_ = "normal")
        for li in links:
            link_name = (li.a['href']).replace('https://www.hotstar.com/in/tv/silicon-valley/8210/', '')

            f.write(f"'{link_name}', \n")

# silicon()
def himym():
    f = open("himym5.txt", 'w')
    with open('D:\Code\Github codes\web-scrap\Stephun\himymS5.html', 'r') as html_file:
    
    
        open_website = html_file.read()
        soup = BeautifulSoup(open_website, 'lxml')
        links = soup.find_all('div', class_ = "normal")
        for li in links:
            link_name = (li.a['href']).replace('https://www.hotstar.com/in/tv/how-i-met-your-mother/8323/', '')

            f.write(f"'{link_name}', \n")
# himym()

def mf():
    f = open("mfS3.txt", 'w')
    with open('D:\Code\Github codes\web-scrap\Stephun\mfS3.html', 'r') as html_file:
        content = html_file.read()

        soup = BeautifulSoup(content, 'lxml')
        links = soup.find_all('div', class_ = "normal")
        for li in links:
            link_name = (li.a['href']).replace('https://www.hotstar.com/in/tv/modern-family/8549/', '')

            f.write(f"'{link_name}', \n")


# mf()

def Si2():
    f = open("test.txt", 'w')
    page = requests.get('https://www.hotstar.com/in/tv/silicon-valley/8210/seasons/season-1/ss-3072')
    print(page.status_code)
    content = page.text
    f.write(content)
    soup = BeautifulSoup(content)
    # print(soup.prettify())
    links = soup.find_all(class_ = "normal")
    print(links)
    # for li in links:
    #     link_name = (li.a['href']).replace('https://www.hotstar.com/in/tv/silicon-valley/8210/', '')
    #     print(link_name)
    #     # f.write(f"'{link_name}', \n")
        

# Si2()

def himym2():
    f = open("himym.txt", 'w')
    for i in range(1,10):
        with open('/Volumes/st3p_m/Git/shuffle/backend/h'+str(i)+'.html', 'r') as html_file:
            open_website = html_file.read()
            soup = BeautifulSoup(open_website,'html.parser')
            links = soup.find_all('div', class_ = "normal")
            for li in links:
                link_name = (li.a['href']).replace('https://www.hotstar.com/in/tv/how-i-met-your-mother/8323/', '')
                f.write(f"'{link_name}', \n")
himym2()