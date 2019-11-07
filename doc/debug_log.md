# 调试记录

[TOC]

本文主要记载调试过程中出现的问题，包括环境设置问题，脚本运行问题以及代码调试问题。其中前两者共同归结为环境问题，与设计问题（代码调试问题）成为本文记录的两大类问题。如无必要，本文不关心一般性语法问题，只会对特殊的非常见语法特性做记录。

## 环境问题

### 1. 无法识别系统函数***$fsdbDumpfile()***和***$fsdbDumpvars()***

出错信息：

```shell
Error-[UST] Undefined System Task Call
xxxx/xxxx/xxxx/
  Undefined System Task call to '$fsdbDumpfile'.
```

解决方法：

一般出现这种问题的原因，是工具的-P参数配置失败所致。这包括相关pli.a文件和novas.tab文件的路径不对，或者软件安装出错导致文件不存在等。需要逐一排除。此处的解决方法是将这两个文件的路径添加到VCS的-P参数下。

### 2. Makefile文件执行权限错误

在运行Makefile时，某些指令，例如使用***ls***命令获取某文件夹下所有rtl文件的路径时，报权限错误：

```shell
@ubuntu:$ make install
ll ./tb/*.v &> tb_flist
/bin/sh: tb_flist: Permission denied
Makefile:14: recipe for target 'install' failed
make: *** [install] Error 1

```

解决方法：

这种问题的原因，在于Makefile是在根用户权限下创建的，但是运行相关的VCS工具和VERDI工具需要在普通用户权限下，造成这种运行权限的差异。解决方法是将Makefile文件所在的文件夹让所有用户都有写权限。在根用户权限下使用**chmod**命令。如下：

```shell
chmod a+w xfan100 -R
```

注：chmod命令第二个参数对于所有者(u)，其他用户(o)，组用户(g)，所有用户(a)，采用“+”或者“-”来修改相关权限。

## 设计问题

