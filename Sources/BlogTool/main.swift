import Foundation
import CommandLineKit
import Rainbow
import BlogPostTool

let cli = CommandLineKit.CommandLine()

let filePath = StringOption(shortFlag: "f", longFlag: "file",
                            helpMessage: "文件路径")

let title = StringOption(shortFlag: "t", longFlag: "title",
                         helpMessage: "标题名称")

let tags = StringOption(shortFlag: "m",longFlag: "tags",
                             helpMessage: "文章分类")

let help = BoolOption(shortFlag: "h", longFlag: "help",
                      helpMessage: "这是一个提高效率的工具集")

let serviceRun = StringOption(shortFlag: "s", longFlag: "serviceRun",
                      helpMessage: "运行查看效果")

cli.addOptions(filePath, title, tags, help,serviceRun)



cli.formatOutput = { s, type in
    var str: String
    switch(type) {
    case .error:
        str = s.lightRed.bold
    case .optionFlag:
        str = s.green.underline
    case .optionHelp:
        str = s.lightBlue
    default:
        str = s
    }
    
    return cli.defaultFormat(s: str, type: type)
}


do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}

let blogPostPath = filePath.value ?? "/Users/Yunis/Documents/GitHub/yunisSong.github.io/_posts"
let postTitle = title.value ?? "默认标题"
let postTags = tags.value ?? ""
let serviceRun0 = serviceRun.value ?? "01"


print("blogPostPath = \(blogPostPath)")
print("postTitle = \(postTitle)")
print("postTags = \(postTags)")


let ci = BlogPost.init(postFilePath: blogPostPath, postTitlle: postTitle, postTags: postTags)


if serviceRun.wasSet
{
    print("运行工具".magenta)
    ci.runShellCommand(command: "cd /Users/Yunis/Documents/GitHub/yunisSong.github.io;jekyll s;open http://127.0.0.1:4000/")
    print("进入当前文件夹".magenta)




}else
{
    ci.creatNewPost()
 
}





