# Framework-iOSAPP

详细的静态库打包APP的方案，便于多APP集成

## 一、 首先创建子APP并打包

一个sonAPP,一个mainAPP,我们将把sonAPP的工程文件集成到mainAPP中。

### 1.1 编写sonAPP的代码

添加简单的事件和界面代码，并添加资源文件（分别在图片管理器assets和图片文件夹里添加文件）

### 1.2 将sonAPP的源代码制作成静态库

![](https://raw.githubusercontent.com/STShenZhaoliang/STImage/master/Framework-iOSAPP/1%E7%94%9F%E6%88%90%E9%9D%99%E6%80%81%E5%BA%93.gif)

静态库:可以是.a和.framework格式，链接时，静态库会被完整地复制到可执行文件中，被多次使用就有多份冗余拷贝。

我们将使用.framework格式，创建framework步骤：

1. 创建的时候 Embed in Application 选择 None, 我们不需要把静态库嵌入到工程中;

2. 在Build Settings中修改mach-o为static library，设置为静态库;

3. 在Build Settings中修改Build Active Architecture Only都为NO，方便在Bebug情况下的使用;

创建完成后，在info中Bundle OS Type code显示的是FMWK

### 1.3 编译阶段（Build Phases）简介

![](https://raw.githubusercontent.com/STShenZhaoliang/STImage/master/Framework-iOSAPP/2phases%E7%AE%80%E4%BB%8B.gif)

编译阶段是当前对象编译过程中的一个阶段，一般系统默认有对象依赖、汇编资源以及复制包资源等。此外，还可以自行添加额外的阶段，甚至还可以用Shell脚本以便在编译处理期间提供更为复杂、精确的操纵。

1. 对象依赖（Target Dependencies）阶段可以让Xcode 知道必须在当前选择的对象编译之前编译的其他依赖对象（比如应用扩展、插件等等）。

2. 编译源文件（Compile Sources）阶段按照Build Rules 选项卡中的定义，用合适的编译器来编译该对象的所有源文件。可以通过修改该阶段的Compiler Flags（编译器标识）来为每个单独文件设置其编译器标识，比如优化设置等等。

3. 链接二进制文件和库（Link Binary With Libraries）中，可以控制该对象需要链接哪些二进制文件和库。只要使用了二进制文件或者库，就必须要链接它们。有些常用的框架（比如说Cocoa框架）并不会显式显示在里面，但是实际上它是包含的，重复添加并不会造成框架的重复引用。

4. 复制包资源（Copy Bundle Resources）阶段中定义了对象中的资源文件，包括应用程序、图标、界面构造器、视频、模板等等。这些资源都会被复制到安装包的Contents/Resources文件夹下。

5. 文件复制（Copy Files）阶段用来标识文件复制的目标路径。可以从Destination（目标）菜单中选择预定义的目标，也可以自己指定路径。文件复制阶段常常用来将文件复制到预定义的位置。预定义的路径包括程序安装包的Resources、Frameworks文件夹、共享框架路径等等。Subpath（子路径）字段则会在Destination菜单中选择的路径后附加一个子路径名称。“Copy only when installing”（仅在安装时复制）命令Xcode只在当前编译设置中包含Install标识时才复制文件。

6. 头文件（Headers）阶段用来为产品指定其头文件以及可见性。作用域（Public、Private和Project）则用来确定头文件的可见性。Public域则包含在最终产品当中，作为可读源代码存在；Private域虽然也包含在最终产品当中，但是不能够直接读取；Project域则不包含在最终产品当中，只有项目在编译对象时才使用。

7. 运行脚本（Run Script）阶段可以使脚本得以运行，脚本可以在脚本编辑器区域当中编辑，也可以直接放入一个脚本文件进来。

### 1.4 编写静态库的入口文件

入口文件负责界面的跳转与数据通信的功能，详细编写见SonSDK.h和SonSDK.m文件

### 1.5 静态库Build Phases的操作

1. 在Compile Sources中，添加除main.m和AppDelegate.m之外的所有源文件

2. 在Link Binary With Libraries中，添加所有的二进制文件和库，与工程APP的一样

3. 在Copy Bundle Resources中，我们将专门制作一个bundle放资源，所以在静态库中的复制包资源可以不放资源文件。

4. 在Headers中，我们将SonSDK放到Public中

![](https://github.com/STShenZhaoliang/STImage/blob/master/Framework-iOSAPP/3Header.png)

### 1.6 制作资源Bundle

![](https://raw.githubusercontent.com/STShenZhaoliang/STImage/master/Framework-iOSAPP/3Bundle%E5%88%B6%E4%BD%9C.gif)

创建Bundle的步骤

1. 在Build Settings中修改Build Active Architecture Only都为NO，方便在Bebug情况下的使用;

2. Base SDK选择iOS系统的

添加资源的步骤

1. 将xib、storyboard等（除LaunchScreen.storyboard）IB文件放到Bundle中

2. 将图片、Assets等图片资源放到Bundle中

3. 将结构化文件等文件放到Bundle中

简而言之，就是和工程中的Bundle Phases中的Copy Bundle Resources中的文件一致，可以不用放LaunchScreen.storyboard。

## 二、创建主APP
因为我们是使用注册方法跳转到子APP，所以我们先添加注册信息。
![](https://raw.githubusercontent.com/STShenZhaoliang/STImage/master/Framework-iOSAPP/4.png)
在工程中我们添加SonBundle.bundle和SonSDK.framework
![](https://raw.githubusercontent.com/STShenZhaoliang/STImage/master/Framework-iOSAPP/5.png)
## 三、打包静态库
### 3.1 选择真机设备

Command+B 编译，如果编译成功，framework的红色将消失

![](https://raw.githubusercontent.com/STShenZhaoliang/STImage/master/Framework-iOSAPP/3_0.png)
![](https://raw.githubusercontent.com/STShenZhaoliang/STImage/master/Framework-iOSAPP/3_1.png)

### 3.2 选择模拟设备

 同样Command+B 编译，选择模拟器的设备
 
### 3.3 打包静态库

首先找到相应的文件夹

![](https://raw.githubusercontent.com/STShenZhaoliang/STImage/master/Framework-iOSAPP/3_31.png)

在查看静态库，查看支持的框架信息，进入SDK的文件夹，使用`lipo -info SonSDK.framework/SonSDK`

![](https://raw.githubusercontent.com/STShenZhaoliang/STImage/master/Framework-iOSAPP/3_32.png)

最后合成一个可以在模拟器和真机都能运行的静态库

`lipo -create Debug-iphonesimulator/SonSDK.framework/SonSDK Debug-iphoneos/SonSDK.framework/SonSDK -output SonSDK.framework`

![](https://raw.githubusercontent.com/STShenZhaoliang/STImage/master/Framework-iOSAPP/3_33.png)

## 四、 主要的问题
### 4.1 资源加载

因为资源文件到放在Bundle中，文件的读取将从Bundle中读取。

举例：获取一个图片的代码
``` 
- (UIImage *)imageNamed:(NSString *)name {
        NSURL* url = [NSBundle.mainBundle resourceURL];
        url = [url URLByAppendingPathComponent:@"SonBundle"];
        url = [url URLByAppendingPathExtension:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithURL:url];
        return [UIImage imageNamed:name
                          inBundle:bundle
     compatibleWithTraitCollection:UIScreen.mainScreen.traitCollection];
}

```

### 4.2 名称冲突
名称冲突，一定要注意找到那些文件引起的冲突，建议是在冲突文件上面加前缀。

引入源文件冲突，需要将源文件的前缀名，如ViewController.m引起了冲突，可以改为SNViewController.m

资源冲突，如icon.png,在sonAPP中，我们可以修改为sn_icon.png

### 4.3 运行时文件
因为运行时代码作用在APP的运行过程中，如果引起错误的现象，一定要注意


