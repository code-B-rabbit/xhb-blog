﻿# Host: 127.0.0.1  (Version: 5.5.15)
# Date: 2020-04-30 20:59:43
# Generator: MySQL-Front 5.3  (Build 4.269)

/*!40101 SET NAMES utf8 */;

#
# Structure for table "friendly_link"
#

DROP TABLE IF EXISTS `friendly_link`;
CREATE TABLE `friendly_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `allowed` bit(1) DEFAULT b'0',
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "friendly_link"
#


#
# Structure for table "message"
#

DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `createTime` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

#
# Data for table "message"
#

INSERT INTO `message` VALUES (56,'.。。。','2020-04-02'),(57,'22222222222222222','2020-04-02');

#
# Structure for table "picture"
#

DROP TABLE IF EXISTS `picture`;
CREATE TABLE `picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filekey` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

#
# Data for table "picture"
#

INSERT INTO `picture` VALUES (9,'9','http://q7xlyvqgm.bkt.clouddn.com/9'),(10,'10','http://q7xlyvqgm.bkt.clouddn.com/10'),(11,'11','http://img.xuhaobo.site/11'),(12,'12','http://img.xuhaobo.site/12'),(14,'14','http://img.xuhaobo.site/14'),(15,'15','http://img.xuhaobo.site/15'),(16,'16','http://img.xuhaobo.site/16'),(17,'17','http://img.xuhaobo.site/17'),(18,'18','http://img.xuhaobo.site/18'),(19,'19','http://img.xuhaobo.site/19'),(20,'20','https://img.xuhaobo.site/20'),(21,'21','http://img.xuhaobo.site/21'),(22,'22','http://img.xuhaobo.site/22'),(23,'23','http://img.xuhaobo.site/23'),(24,'24','http://http://blog.domain.com/24'),(25,'25','http://http://img.xuhaobo.site/25'),(26,'26','http://img.xuhaobo.site/26'),(27,'27','http://img.xuhaobo.site/27'),(28,'28','http://img.xuhaobo.site/28'),(29,'29','http://img.xuhaobo.site/29');

#
# Structure for table "tag"
#

DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

#
# Data for table "tag"
#

INSERT INTO `tag` VALUES (2,'数据结构与算法'),(3,'计组'),(6,'计算机网络'),(8,'spring boot'),(9,'前端开发'),(14,'python机器学习'),(15,'python数据挖掘');

#
# Structure for table "article"
#

DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) DEFAULT NULL,
  `createTime` date DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `firstPicture` varchar(255) DEFAULT NULL,
  `visit` bigint(20) DEFAULT '0',
  `content` longtext,
  `published` bit(1) DEFAULT b'0',
  `info` longtext,
  PRIMARY KEY (`id`),
  KEY `fk_article_tag` (`tid`),
  CONSTRAINT `fk_article_tag` FOREIGN KEY (`tid`) REFERENCES `tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8;

#
# Data for table "article"
#

INSERT INTO `article` VALUES (3,15,'2020-04-01','<<深入理解计算机系统>>之动态链接','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3020495497,2923874859&fm=26&gp=0.jpg',5,'static:本地链接器符号---在模块中任何位置都可见,但是不能被其他模块所引用\r\n\t本地定义的变量: .symtab符号表并不包含本地变量定义的符号,这些符号由栈进行管理\r\n\r\n2.bss节与COMMON节的区分:\r\n    \r\n\tbss:局部未初始化||局部为0||全局为0(static为局部)\r\n\tCOMMON:全局为初始化\r\n\r\n3.未初始化的变量(如上说的.bss,COMMON)在重定向目标文件以及可执行目标文件中没有实际分配空间,但是在实际运行过程中按照符号表中的类型分配',b'1',NULL),(6,3,'2020-04-01','<<深入理解计算机系统>>第七章易错点总结','https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3394611025,2062792490&fm=26&gp=0.jpg',1,'1.对static以及模块内的变量定义的区分:\r\n\r\n\tstatic:本地链接器符号---在模块中任何位置都可见,但是不能被其他模块所引用\r\n\t本地定义的变量: .symtab符号表并不包含本地变量定义的符号,这些符号由栈进行管理\r\n\r\n2.bss节与COMMON节的区分:\r\n    \r\n\tbss:局部未初始化||局部为0||全局为0(static为局部)\r\n\tCOMMON:全局为初始化\r\n\r\n3.未初始化的变量(如上说的.bss,COMMON)在重定向目标文件以及可执行目标文件中没有实际分配空间,但是在实际运行过程中按照符号表中的类型分配',b'1','1.对static以及模块内的变量定义的区分:\r\n3.未初始化的变量(如上说的.bss,COMMON)在重定向目标文件以及可执行目标文件中没有实际分配空间,但是在实际运行过程中按照符号表中的类型分配'),(7,15,'2020-04-09','pandas库的相关文件IO操作','https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3506000979,3290554988&fm=11&gp=0.jpg',0,'',b'0',NULL),(8,3,'2020-04-02','[python]第一天数据挖掘','https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3890848816,3171555074&fm=26&gp=0.jpg',20,'#python数据挖掘之matplotlab的使用\r\n\t最近为了开学的大创,在学习一点python数据挖掘相关的内容,简单地看黑马的视频学了一点点的matplotlab.....感觉这一块还是不难的,大概就是调api吧,具体使用还是要多用得好\r\n至于什么是matplotlab,为什么要使用matplotlab这里就不细说了....\r\n##1.容器层(画布)\r\n&emsp;&emsp;这个没什么好说的,就是要在画布上画画的道理,如果要生成一组统计图就只建立一个画布而不需要坐标系：\r\n```python\r\nfig = plt.figure(figsize=(a, b), dpi=dpi)\r\n#figsize a,b指定画布长宽,dpi指定清晰度\r\n```\r\n&emsp;&emsp;如果要建立多个图像则需要建立坐标系\r\n```python\r\nﬁgure, axes = plt.subplots(nrows=, ncols=, ﬁgsize=, dpi=)\r\n#nrows代表行数,ncols代表列数,控制划分区域,而后的、figsize和dpi用法则与之前相同\r\n\r\n```\r\n两者间使用的api略有不同,这里我举例折线图把建立坐标系所使用的的api如下\r\n```python\r\nimport matplotlib.pyplot as plt\r\nimport random\r\n%matplotlib inline\r\n\r\nx=[i for i in range(60)]\r\nx_label=[\"值为{}\".format(i) for i in x]\r\n\r\ny=[int(random.uniform(10,18)) for i in range(60)]\r\ny_label=[\"值为{}\".format(i) for i in y]\r\n\r\nx2=[i for i in range(60)]\r\nx2_label=[\"值为{}\".format(i) for i in x]         \r\n\r\ny2=[int(random.uniform(10,18)) for i in range(60)]  //这里通过列表生成式不断生成随机数\r\ny2_label=[\"值为{}\".format(i) for i in y]\r\n\r\nfigure,axes=plt.subplots(nrows=1,ncols=2)\r\n\r\n#plt.figure(figsize=(20,8),dpi=80)    画布 plt.figure()\r\n\r\n#画图 plot函数先传x轴上的再传y轴上的\r\n\r\naxes[0].plot(x,y,color=\"r\",label=\"第一个图像\",linestyle=\"--\")     #linestyle控制线条的粗细(忽然感觉)\r\naxes[1].plot(x2,y2,color=\"g\",label=\"第二个图像\",alpha=0.8)       #实际的画的动作,alpha控制透明度\r\n\r\n\r\n#辅助显示\r\naxes[0].grid(alpha=0.5,linestyle=\"--\")      #grid设置表格\r\naxes[1].legend()              #选择图例位置(默认为best) ,之前给设置的plot时的 图像时显示\r\naxes[0].legend()\r\n\r\naxes[0].set_xticks(x[::5])     #设置辅助显示x轴,增加标注刻度\r\naxes[0].set_xticklabels(x_label[::5])\r\naxes[0].set_yticks(y[::5])     #设置辅助显示y轴,增加标注刻度\r\naxes[0].set_yticklabels(y_label[::5])\r\n\r\naxes[1].set_xticks(x2[::5])     #设置辅助显示x轴,增加标注刻度\r\naxes[1].set_xticklabels(x2_label[::5])\r\naxes[1].set_yticks(y2[::5])     #设置辅助显示y轴,增加标注刻度\r\naxes[1].set_yticklabels(y2_label[::5])\r\n\r\naxes[0].set_xlabel(\"x轴。。。。\")\r\naxes[0].set_ylabel(\"y轴。。。。\")\r\n\r\nplt.show()\r\n```\r\n&emsp;&emsp;当然里面也有图像层的对应用法,可以把这种思路的不同理解成不建立坐标系时是面向过程的,而建立坐标系后则是面向对象的。\r\n\r\n##2.辅助显示层\r\n\t同样地,辅助显示层也是大同小异,常用地可以控制x,y轴刻度,以及描述信息,添加网格,显示图例等,这里只描述下单个图像的api\r\n```python\r\nplt.xticks([i for i in range(10)][::5],[\"i的值为{}\".format(i) for i in range(10)][::5])   #前面的是实际的x轴数据,后面是所修改的x,y刻度\r\nplt.xlabel(\"x轴上所加的标签\")          #用字符串指代x轴所加标签\r\nplt.grid()       #添加网格,这个没什么可说的\r\n\r\nplt.legend()       #这个要与绘制图像的Api一起使用,之后会提到\r\n```\r\n\r\n##3.图像层\r\n\r\n\t图像层就有很多的不同了,需要我们根据不同的数据选取合适的图像\r\n\t都有的属性:linestyle:线条类型  alpha:透明度 color:色彩\r\n####1.折线图--变化趋势:\r\n```python\r\nplt.plot([i for i in range(10)],[j for j in range(10)],label=\"直线\") #(x,y,图例说明)\r\n```\r\n####2.散点图--是否存在关系:\r\nplt.scatter(x,y,...)\r\n\r\n####3.柱状图:\r\nplt.bar(x,y,...)\r\n柱状图在进行比较时通常会有多个一组一起比,这里需要考虑一下偏移量的问题\r\n例如:\r\n```python\r\nimport matplotlib.pyplot as plt\r\nimport random\r\n%matplotlib inline\r\n\r\nplt.figure(figsize=(10,10),dpi=80)\r\n# plt.bar([i for i in range(10)],[j for j in range(10)],x_label=\"x轴\")\r\n\r\nplt.bar([i for i in range(10)],[j for j in range(10)],color=\'b\',width=0.2) #(x,y,图例说明)\r\nplt.bar([i+0.2 for i in range(10)],[j for j in range(10)],color=\'r\',width=0.2)\r\n\r\n\r\nplt.xticks([i+0.1 for i in range(10)],[\"i的值为{}\".format(i) for i in range(10)])   #前面的是实际的x轴数据,后面是所修改的x,y刻度,这里向右平移0.1使其恰好居中\r\nplt.xlabel(\"x轴上所加的标签\")          #用字符串指代x轴所加标签\r\nplt.grid()       #添加网格,这个没什么可说的\r\n\r\n#plt.legend()       #这个要与绘制图像的Api一起使用,之后会提到\r\n\r\nplt.show()\r\n```\r\n####直方图:一段连续范围内各数所占的比例\r\n```python\r\nplt.hist(x,bin)  #normed==true为显示频率\r\n# bin为所分的组数,可以以下形式求\r\nl=[i for i in range(10)]\r\ndistance=1   #设置组距\r\nbin=(max(l)-min(l))/distance\r\nplt.xticks(x[::distance])\r\n```\r\n####饼图---占比\r\n函数格式:```python\r\ndef pie(x, explode=None, labels=None, colors=None, autopct=None,\r\n        pctdistance=0.6, shadow=False, labeldistance=1.1, startangle=None,\r\n        radius=None, counterclock=True, wedgeprops=None, textprops=None,\r\n        center=(0, 0), frame=False, rotatelabels=False, hold=None, data=None)\r\n```\r\nx为x轴(自动生成占比)\r\nlabels为每部分的标签\r\ncolors为颜色\r\nautopct为保留的位数%1.2ff%%\r\n```python\r\nplt.pie(x,labels=[i for i in x],autopct=\'%1.2f%%\')\r\n```\r\n\r\n![](http://q7xlyvqgm.bkt.clouddn.com/9)',b'1',NULL),(105,2,'2020-04-02','leetcode 57插入区间','https://assets.leetcode-cn.com/aliyun-lc-upload/default_avatar.png',8,'好久没刷算法题了......\r\n乍一刷有点自闭........\r\n虽说代码写出来了吧但是感觉还是不太好\r\n\r\n```java\r\n\r\n```java\r\nclass Solution {\r\n    public static boolean contains(int []insert,int []tocheck)\r\n    {\r\n        if((insert[0]<=tocheck[0]&&insert[1]<=tocheck[1]&&insert[1]>=tocheck[0])||\r\n        (insert[1]>=tocheck[1]&&insert[0]>=tocheck[0]&&insert[0]<=tocheck[1])||(insert[1]>=tocheck[1]&&insert[0]<=tocheck[0]))\r\n        {\r\n            return true;\r\n        }\r\n        else{\r\n            return false;\r\n        }\r\n    }\r\n```\r\n\r\n```java\r\npublic int[][] insert(int[][] intervals, int[] newInterval) {\r\n        if(intervals==null||intervals.length==0)\r\n        {\r\n            System.out.println(1);\r\n            int [][] b=new int[1][2];\r\n            b[0]=newInterval;\r\n            return b;\r\n        }\r\n        else if(intervals.length!=0){\r\n            List<int[]> anw=new ArrayList<>();   //存储最终结果\r\n            int[] tochange=new int[2];       //中间由于插入数组发生变化的数组\r\n            boolean flag=false;                //记录重叠状态\r\n            boolean hasContain=false;   //判断是否重叠过\r\n            for(int i=0;i<intervals.length;i++)\r\n            {\r\n                if(contains(newInterval,intervals[i])==true)       //若判断包含关系则开始更新\r\n                {\r\n                    System.out.println(flag);\r\n                    hasContain=true;   //证明有重叠过\r\n                    if(flag==true)\r\n                    {\r\n                        if(tochange[1]<=intervals[i][1])\r\n                        {\r\n                            tochange[1]=intervals[i][1];\r\n                        }\r\n                    }\r\n                    else if(flag==false)\r\n                    {\r\n                        tochange=intervals[i];\r\n                        if(tochange[0]>=newInterval[0])\r\n                    {\r\n                        tochange[0]=newInterval[0];\r\n                    }\r\n                    if(tochange[1]<=newInterval[1])\r\n                    {\r\n                        System.out.println(tochange[1]);\r\n                        tochange[1]=newInterval[1];\r\n                    }\r\n\r\n                        flag=true;         //进入检验重叠的模式中\r\n                    }\r\n                }\r\n                else{\r\n                    if(flag==true)   //之前有在重叠模式里的元素就先加进去,不重叠的元素一定加进去\r\n                    {\r\n                        anw.add(tochange);\r\n                        flag=false;\r\n                    }\r\n                    anw.add(intervals[i]);\r\n                }\r\n            }\r\n                    if(flag==true)   //之前有在重叠模式里的元素就先加进去,不重叠的元素一定加进去\r\n                    {\r\n                        anw.add(tochange);\r\n                        flag=false;\r\n                    }\r\n            if(hasContain==false)       //从未发生过重叠则要根据之前的结果进行插入\r\n            {\r\n                for(int i=0;i<anw.size();i++)\r\n                {\r\n                    if(i==0&&anw.get(i)[0]>newInterval[1])\r\n                    {\r\n                       anw.add(0,newInterval);\r\n                        break;\r\n                    }\r\n                    if(i==anw.size()-1&&anw.get(i)[1]<newInterval[0])\r\n                    {\r\n                        anw.add(newInterval);\r\n                        break;\r\n                    }\r\n                    else if(anw.get(i)[1]<newInterval[0]&&anw.get(i+1)[0]>newInterval[1])\r\n                    {\r\n                        anw.add(i+1,newInterval);\r\n                        break;\r\n                    }\r\n                }\r\n            }\r\n            int [][]retArray=new int[anw.size()][2];\r\n            for(int i=0;i<anw.size();i++)\r\n            {\r\n                retArray[i]=anw.get(i);   //移入一个二维数组中去\r\n            }\r\n            return retArray;\r\n        }\r\n        return null;\r\n    }\r\n    \r\n}\r\n```\r\n\r\n........\r\n```',b'1',NULL),(106,8,'2020-04-02','spring boot解决文件存储的虚拟路径问题','http://img.xuhaobo.site/74',2,'我们都知道,有些大文件我们无法放入数据库中,需要在数据库中存储存储路径而在本机中去获取,很多企业有自己的文件服务器,我在新血来潮想开发音乐网站的过程中就遇到了相关的问题.......y1s1,有点酸爽......找了半天csdn....也算是终于找到相关的地址了....项目还在接着开发,目前也只是找到了windows的解决方案....linux等部署的时候更新吧23333\r\n\r\n我参考的csdn文章是:\r\n\r\n&emsp;&emsp;首先说一下需求:就是从前端传文件到后端,之后后端通过输入输出流存储文件到指定路径,之后存储到本地,随后访问前端时后端把本地地址给前端,(这里看着是tm挺简单的),这里可能有的网站说前端src可以用file://获取本地文件,但事实上很多浏览器现在已经开始不支持访问本地文件了,我们如果想要访问本地文件,所以我们需要配置一个类能够建立本地文件与前端uri的映射,这样虽然看似套上了uri的壳,但我们依然可以获取本地文件了\r\n\r\n核心的java配置类代码如下:\r\n```java\r\n    @Configuration\r\n    public class FileConfig extends WebMvcConfigurerAdapter {\r\n    \r\n        public static String filePath=\"D:\\\\music\\\\\"; //配置的本地物理保存地址\r\n    \r\n    \r\n        //核心的配置方法,实现映射,我们可以理解成:/file/文件名请求路径   实质指的是 file:///D:/music/文件名\r\n        @Override\r\n        public void addResourceHandlers(ResourceHandlerRegistry registry) {\r\n           registry.addResourceHandler(\"/file/**\").addResourceLocations(\"file:///\"+filePath);\r\n           super.addResourceHandlers(registry);\r\n        }\r\n    \r\n    \r\n        //自己写的将文件名转化为uri的方法\r\n        public static String getURI(String str)\r\n        {\r\n            return \"/file/\"+str;\r\n        }\r\n    \r\n    \r\n    }\r\n```\r\n\r\n这样我们就可以通过请求路径来实现访问本地数据了\r\n实际存储到数据库,前端的src都是转化后的请求路径即可\r\n\r\n这里也贴一下前端的代码\r\n前端用的是thymeleaf模板渲染的技术\r\n```html\r\n<!DOCTYPE html>\r\n<html lang=\"en\" xmlns:th=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n    <meta charset=\"UTF-8\">\r\n    <title>Title</title>\r\n</head>\r\n<body>\r\n\r\n<!--html5 audio 从后端取src-->\r\n\r\n<audio th:if=\"${musics}\" th:each=\"music:${musics}\" controls=\"controls\" th:src=\"@{${music.uri}}\">\r\n    Your browser does not support the audio element.\r\n</audio>\r\n\r\n<!--文件上传表单,注意这里一定要加 enctype=\"multipart/form-data\"属性-->\r\n\r\n<form method=\"post\" action=\"upload\" enctype=\"multipart/form-data\">\r\n    <input type=\"file\" name=\"file\" accept=\"music/*\"/><br>\r\n    <input name=\"name\" placeholder=\"请输入歌曲名\"/><br>\r\n    <input name=\"style\" placeholder=\"请输入歌曲风格\"/><br>\r\n    <input name=\"singer\" placeholder=\"请输入歌手名\"/><br>\r\n    <input type=\"submit\">\r\n</form>\r\n\r\n\r\n</body>\r\n</html>\r\n```',b'1',''),(107,15,'2020-04-09','Numpy ndarray数组的生成以及相关修改操作','https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3890848816,3171555074&fm=26&gp=0.jpg',0,'```python\r\nimport matplotlib.pyplot as plt\r\nimport random\r\nimport numpy as np\r\n%matplotlib inline\r\n#修改数组形状(因为是修改一个对象,所以这里都直接采用对象.方法而非np.函数的方式进行操作)\r\narray1=np.array([[1,2,3],[1,1,1]])\r\narray2=array1.reshape((3,-1))     #reshape不能改变其本身在内存中的大小,因此形状的乘积,面积不同\r\nprint(array2)\r\nprint(array2.T)\r\n#修改数组的类型\r\nprint(array2.dtype)\r\nprint(array2.astype(\"float32\").dtype)\r\nprint(array2.tostring())   #序列化(哪天专门再写个文章说一下序列化吧哈哈哈)\r\nprint(np.unique(array2))\r\n```',b'0',NULL),(123,6,'2020-04-07','测试0',NULL,0,NULL,b'1',NULL),(124,6,'2020-04-08','测试1',NULL,1,NULL,b'1',NULL),(125,6,'2020-04-09','测试2',NULL,0,NULL,b'1',NULL),(126,6,'2020-04-10','测试3',NULL,0,NULL,b'1',NULL),(127,6,'2020-04-11','测试4',NULL,0,NULL,b'1',NULL),(128,6,'2020-04-18','测试11',NULL,0,NULL,b'1',NULL),(129,6,'2020-04-19','测试12',NULL,0,NULL,b'1',NULL),(130,6,'2020-04-20','测试13',NULL,0,NULL,b'1',NULL),(131,6,'2020-04-21','测试14',NULL,0,NULL,b'1',NULL),(132,6,'2020-04-22','测试15',NULL,0,NULL,b'1',NULL),(133,6,'2020-04-23','测试16',NULL,0,NULL,b'1',NULL),(134,6,'2020-04-24','测试17',NULL,0,NULL,b'1',NULL),(135,6,'2020-04-25','测试18d','',0,'',b'1',NULL),(136,6,'2020-04-26','测试19',NULL,0,NULL,b'1',NULL),(137,6,'2020-04-07','测试(2)0','',0,'',b'1',NULL),(138,6,'2020-04-08','测试(2)1',NULL,0,NULL,b'1',NULL),(139,6,'2020-04-09','测试(2)2',NULL,1,NULL,b'1',NULL),(140,6,'2020-04-10','测试(2)3',NULL,4,NULL,b'1',NULL),(141,6,'2020-04-11','测试(2)4',NULL,1,NULL,b'1',NULL),(142,6,'2020-04-09','2','2',0,'22222222',b'1',NULL),(143,6,'2020-04-09','33333','33d',0,'',b'0',NULL),(144,6,'2020-04-15','1','1',0,'1',b'1',NULL),(145,6,'2020-04-15','1','1',0,'1',b'1',NULL),(146,6,'2020-04-15','1','1',1,'1',b'1',NULL),(147,6,'2020-04-15','5','2',14,'4',b'1',NULL),(148,6,'2020-04-15','4','4',0,'4',b'0',NULL),(149,6,'2020-04-15','22','22',0,'2222',b'0',NULL),(150,3,'2020-04-15','222222','112',10,'![](http://img.xuhaobo.site/14)阿ddddddd',b'1','6666666666666666666666666666666'),(151,6,'2020-04-15','4','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2317725689,390131353&fm=26&gp=0.jpg',5,'4',b'1','444444444444444444444444444444444444444444444444444444444444444'),(152,6,'2020-04-17','2','http://img.xuhaobo.site/74',21,'3',b'1','adfmg;'),(153,9,'2020-04-29','咩咩咩咩吗','https://localhost/admin/addArticle',14,'333333333333333333',b'1','333333333333333333'),(154,9,'2020-04-29','.。。。。。。。。。。。','。。。。。。。。',7,'。。。。。。。。。。。。。。。\r\n![](http://img.xuhaobo.site/蝙蝠侠.jpg)\r\n![](http://img.xuhaobo.site/71cf3bc79f3df8dccc412ce4c211728b47102842.jpg)',b'1','。。。。。。');

#
# Structure for table "user"
#

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(5) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

#
# Data for table "user"
#

INSERT INTO `user` VALUES (2,'徐浩博','c1d649d9112fd39916999c35272ca0fe','admin','511924849@qq.com'),(3,'张奥','c53a2b751bbc0eee6c082755afdb1e6e','admin','511928850@qq.com'),(4,'傻逼','c53a2b751bbc0eee6c082755afdb1e6e','user','511928859@qq.com'),(5,'张伟杰','c53a2b751bbc0eee6c082755afdb1e6e','user','511928868@qq.com'),(7,'333','5ba0c7e4d016e4fc8810411d3a7cf6f1','user','511928879@qq.com'),(8,'444','5ba0c7e4d016e4fc8810411d3a7cf6f1','user','511928449@qq.com'),(9,'刘洋','c53a2b751bbc0eee6c082755afdb1e6e','user','511238849@qq.com'),(10,'徐xu','52c69e3a57331081823331c4e69d3f2e','user','511928858@qq.com'),(11,'ddf','c53a2b751bbc0eee6c082755afdb1e6e','user','666@qq.com'),(12,'张傲','c53a2b751bbc0eee6c082755afdb1e6e','user','511928849@qq.com'),(13,'章啊','e10adc3949ba59abbe56e057f20f883e','user','511938849@qq.com');

#
# Structure for table "comment"
#

DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) DEFAULT NULL,
  `content` longtext,
  `createTime` date DEFAULT NULL,
  `parentID` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comment_article` (`aid`),
  KEY `comment_parentComment` (`parentID`),
  KEY `comment_user` (`uid`),
  CONSTRAINT `comment_parentComment` FOREIGN KEY (`parentID`) REFERENCES `comment` (`id`),
  CONSTRAINT `comment_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_comment_article` FOREIGN KEY (`aid`) REFERENCES `article` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8;

#
# Data for table "comment"
#

INSERT INTO `comment` VALUES (155,152,'这牛逼','2020-04-27',NULL,2),(156,152,'哈哈哈','2020-04-27',NULL,3),(157,152,'。。。','2020-04-27',NULL,3),(158,152,'呵呵哒','2020-04-27',NULL,2),(159,152,'艹','2020-04-27',NULL,9),(160,152,'艹','2020-04-27',NULL,9),(161,152,'呵呵呵','2020-04-27',160,2),(162,152,'哈哈哈艹','2020-04-27',161,3),(163,152,'emmm','2020-04-27',162,3),(164,152,'....','2020-04-27',NULL,3),(165,151,'的','2020-04-27',NULL,2),(166,151,'的','2020-04-27',165,2),(167,151,'3333','2020-04-28',NULL,11),(168,151,'4444','2020-04-28',165,11),(169,152,'的的','2020-04-28',162,2),(170,106,'呃呃呃','2020-04-29',NULL,2),(171,106,'方法','2020-04-29',170,2),(172,105,'发','2020-04-29',NULL,2),(173,105,'多对多','2020-04-29',NULL,2),(174,105,'哈哈哈哈哈哈哈哈哈哈哈','2020-04-29',NULL,2),(175,105,'好久没刷算法题了……\n乍一刷有点自闭……..\n虽说代码写出来了吧但是感觉还是不太好','2020-04-29',NULL,2),(176,105,'好久没刷算法题了……\n乍一刷有点自闭……..\n虽说代码写出来了吧但是感觉还是不太好','2020-04-29',175,2),(177,152,'class=\"comment-body\"','2020-04-29',157,2),(178,152,'卡纳瓦罗盛赞中国的抗疫工作，拉莫斯望西班牙向中国学习\n虎扑足球 04-29 09:07','2020-04-29',NULL,2),(179,152,'荣荣荣荣荣荣荣荣','2020-04-29',178,2),(180,152,'测试测试测试测试','2020-04-29',179,2),(181,152,'测试','2020-04-29',NULL,2),(182,152,'测试','2020-04-29',NULL,2),(183,152,'卡纳瓦罗盛赞中国的抗疫工作，拉莫斯望西班牙向中国学习 虎扑足球 04-29 09:07','2020-04-29',NULL,2),(184,153,'d','2020-04-30',NULL,2),(185,153,'2','2020-04-30',NULL,2),(186,153,'4444444','2020-04-30',NULL,2),(187,153,'d','2020-04-30',NULL,2),(188,153,'dd','2020-04-30',NULL,2),(189,153,'222','2020-04-30',NULL,2),(190,153,'222222','2020-04-30',NULL,2),(191,153,'256','2020-04-30',190,2),(192,153,'dddd','2020-04-30',NULL,2),(193,154,'呃呃呃呃呃呃呃呃','2020-04-30',NULL,2),(194,154,'222222','2020-04-30',NULL,2),(195,154,'呃呃呃','2020-04-30',194,2),(196,151,'2222222','2020-04-30',NULL,13),(197,151,'艹','2020-04-30',167,13);