# XPatchLib.Net 帮助

## 编译

可以直接使用 `build.bat` 脚本进行编译。该脚本会自动根据设置编译 `XPatchLib.Net` 项目，并编译 `\src\NET40\NET40.shfbproj`，最后将帮助文档复制至 `\docs\` 目录。

NET40版本编译时会自动编译其他版本，并将内容合并至结果中。详情见：[Version Builder Plug-In](https://ewsoftware.github.io/SHFB/html/6c03afba-18d0-4270-b521-c2015c4d97b3.htm)

编译 HelperBuilder 相关帮助文档项目时需要使用 [Sandcastle Help File Builder](https://github.com/EWSoftware/SHFB/releases)。

默认输出 `WebSite` 类型。如需输出 `chm` 类型则需要配合使用 [HTML Help Workshop](http://www.microsoft.com/en-us/download/details.aspx?id=21138)。

## 模版

`\PresentationStyles` 中包含了修改后的 `VS2013` 模版，修改内容如下：

* 主要修改了 css 中的 `Font-Family` 。

* 去除 `globalTemplates.xsl` 中的 `logoColumn` 。

将 `\PresentationStyles` 复制至 `%ProgramFiles(x86)%\EWSoftware\Sandcastle Help File Builder` 安装目录，覆盖现有内容即可。