import sys
import getopt

from termcolor import colored

address = ""
updateDescription = ""
updateInfoFile = "/Users/XXX/updateDescription.txt"

def inputServer():
    print(colored("输入服务器地址,输入对应序号即可,服务器地址如下：","blue"))
    print(colored("""
    "1. 测试内网138": "http://XXXXXX:8082",
    "2. 测试外网119": "http://XXXXXX:8082",
    "3. 测试Https138": "https://XXXXXX.cn",
    "4. 验收环境": "http://XXXXXX:8000",
    "5. Https验收环境": "https://XXXXXX:8083",
    "6. 生产环境": "http://XXXXXX:8000",
    "7. 生产https环境": "https://XXXXXXX",
        ""","yellow"))
    inputIndex = input()
    servers = ["测试内网138","测试外网119","测试Https138","验收环境","Https验收环境","生产环境","生产https环境"]
    address = servers[int(inputIndex) - 1]
    print(address)
    if address not in servers:
        print(colored("请输入正确的服务器地址","red"))
        inputServer()
    else:
        print(colored("输入的地址为 %s"%(address),"green"))
        return address



def inputUpdateInfo(server):
    print("请输入本次更新内容")

    updateInfo = file_write()
    print(updateInfo)
    if updateInfo:
        updateDescription = "AppName （%s)\n下载地址：https://XXXXXXX\n更新：\n%s"%(server,updateInfo)
        print(colored("本次更新内容为 %s"%(updateDescription),"green"))
        return updateDescription
    else:
        print(colored("请输入更新内容","red"))
        inputUpdateInfo(server)



def file_write():
    try:
        f = open(updateInfoFile, 'w')
    except Exception as e:
        print(colored("请输入正确的文本地址 ： updateInfoFile","red"))
        sys.exit()
    print('请输入内容【单独输入\':q\'保存退出】：')
    while True:
        file_content = input()
        if file_content != ':q':
            f.write('%s\n' % file_content)
        else:
            break
    f.close()

    f = open(updateInfoFile, 'r')
    updateInfo=f.read()
    f.close()
    return updateInfo

def main():
    ser = inputServer()
    inputUpdateInfo(ser)

main()