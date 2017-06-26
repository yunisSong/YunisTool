import Foundation
import PathKit
import Rainbow
public struct BlogPost {
    
    let postFilePath : String
    let postTitlle : String
    let postTags : String
    
    
    public init (postFilePath:String,postTitlle:String,postTags:String) {
        self.postFilePath = postFilePath
        self.postTitlle = postTitlle
        self.postTags = postTags
    }
    
    //运行shell
   public func runShellCommand(command: String) -> String? {
        let pipe = Pipe()
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = ["-c", String(format: "%@", command)]
        task.standardOutput = pipe
        let file = pipe.fileHandleForReading
        task.launch()
        guard let result = NSString(data: file.readDataToEndOfFile(), encoding: String.Encoding.utf8.rawValue)?.trimmingCharacters(in: NSCharacterSet.newlines) else {
            return nil
        }
        return result as String
    }
    //新建文件
    public func creatNewPost()
    {
        //获取当前路径
        let p = Path.init(self.postFilePath)
        //获取系统时间
        let time = self.getSysDate()
        //拼接得到文件路径
        let postPath = p + "\(time)-\(self.postTitlle).md"
        //创建文件
        let sucess = self.touchPostFile(path: postPath.url)
        if sucess
        {
            print("文件创建成功，路径位于 \(postPath.string)".lightBlue)
            //组装默认文本
            let content = self.createDefaultContentHeader(title: self.postTitlle, tags: self.postTags, time: time)
            //默认文本写入文件
            let sucess = self.writeDefaultContentToPost(content: content, postFilePath: postPath.url)

            if sucess
            {
                //打开文件进行编辑
              let error = runShellCommand(command: "open \(postPath.string)")
                if error != nil {
                }
            }
            
        }


    }
    
    //创建文件
    func touchPostFile(path:URL) -> Bool {
        let manager = FileManager.default
        
        let file = path
        let exist = manager.fileExists(atPath: file.path)
        if !exist {
            let createSuccess = manager.createFile(atPath: file.path,contents:nil,attributes:nil)
            print("文件创建结果: \(createSuccess)".lightBlue)
        }
        return true
    }

    //组装默认内容
    func createDefaultContentHeader(title:String,tags:String,time:String) -> String {
        
        let content = "---\n" +
        "layout:     post\n" +
        "title:      \(title)\n" +
        "subtitle:   在不断填坑中前进。。\n" +
        "date:       \(time)\n" +
        "author:     三十一\n" +
        "header-img: img/post-bg-nextgen-web-pwa.jpg\n" +
        "header-mask: 0.3\n" +
        "catalog:    true\n" +
        "tags:\n" +
        "   - \(tags)\n" +
        "---\n\n" +
        "# \(title)"

        
        print(content.lightRed)
        return content
    }
    
    //获取当前系统时间，并转化为字符串
    func getSysDate() -> String {
        let nowDate = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: nowDate as Date)
        return dateString
    }
    //填充默认内容到文件
    func writeDefaultContentToPost(content:String,postFilePath:URL) -> Bool {
        
        //定义可变数据变量
        let data = NSMutableData()
        //向数据对象中添加文本，并制定文字code
        data.append(content.data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        //用data写文件
        return data.write(toFile: postFilePath.path, atomically: true)

    }
    
    
    //打开文件近些编写 后续编辑是在写
    func openPostFileEdit(filePath:String) {
        
        
    }


    
}
