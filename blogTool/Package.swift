import PackageDescription

let package = Package(
    name: "YunisTool",
    targets: [
        Target(name:"BlogTool",dependencies:["BlogPostTool"]),
        Target(name:"BlogPostTool",dependencies:[]),
    ],
    dependencies:[
        .Package(url:"https://github.com/onevcat/Rainbow.git",majorVersion:2),
        .Package(url:"https://github.com/jatoben/CommandLine.git","3.0.0-pre1"),
        .Package(url:"https://github.com/kylef/PathKit", majorVersion: 0, minor: 8)
    ]
)
