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
                      helpMessage: "本地运行查看效果")

let commitCode = StringOption(shortFlag: "c", longFlag: "commitCode",
                              helpMessage: "提交代码")

let updateDescription = StringOption(shortFlag: "d", longFlag: "description",
                              helpMessage: "提交到蒲公英的信息")


cli.addOptions(filePath, title, tags, help,serviceRun,commitCode)

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

let blogPostPath = filePath.value ?? "/Users/Yunis/Documents/Github/yunisSong.github.io/_posts"
let postTitle = title.value ?? "默认标题"
let postTags = tags.value ?? ""
let serviceRun0 = serviceRun.value ?? "01"
let commitCode0 = commitCode.value ?? "默认提交内容"


print("blogPostPath = \(blogPostPath)")
print("postTitle = \(postTitle)")
print("postTags = \(postTags)")


let ci = BlogPost.init(postFilePath: blogPostPath, postTitlle: postTitle, postTags: postTags)


if serviceRun.wasSet
{
    print("******构建本地运行版本******".magenta)
    ci.runShellCommand(command: "open http://127.0.0.1:4000/;cd /Users/Yunis/Documents/Github/yunisSong.github.io;jekyll s;")
}else if commitCode.wasSet
{
    print("*******开始提交代码*******".magenta)
    ci.runShellCommand(command: "cd /Users/Yunis/Documents/Github/yunisSong.github.io;git add .;git commit -m \"\(commitCode0)\";git push")
    print("*******提交代码完成*******".magenta)
}
else
{
    print("*******创建新文章*******".magenta)

    ci.creatNewPost()
 
}





