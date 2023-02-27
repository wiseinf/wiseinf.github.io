---
categories: ["成本管理"]
tags: ["Wisecost"]
title: "安装部署"
linkTitle: "安装部署"
weight: 1
description: >
  描述了如何安装Wisecost的详细步骤.
resources:
- src: "**.{png,jpg}"
  title: "Image #:counter"
  params:
    byline: "Wiseinf Inc."
---

{{% pageinfo %}}
Wisecost提供了云原生应用成本监控、管理和优化能力。
{{% /pageinfo %}}

## 前置条件

* Mysql数据库
* kubernetes集群，版本1.20及以上

## 克隆安装脚本

1. 打开控制台，输入`git clone https://github.com/wiseinf/setup.git`,将安装脚本克隆到本地。
我们提供了2个仓库地址，方便大家根据需求来克隆到本地。

| 仓库 | 仓库地址 |
| --- | :--- |
| Github | https://github.com/wiseinf/setup.git |
| Gitee | https://gitee.com/wiseinf/setup.git |

> 后续步骤都假设已将`setup`库克隆到用户主目录，若未克隆到用户主目录，则需要根据实际情况调整命令中的文件路径。

## 初始化数据库

> 假设Mysql数据库主机地址为：`127.0.0.1`.

1. 在控制台执行命令`mysql -h127.0.0.1 -uroot`，输入密码，登录mysql数据库。其中`127.0.0.1`为Mysql主机地址。
2. 在`mysql>`提示符下执行如下命令，创建`storage`库和`wisecost`库及相应表。

    ```sh
        mysql> source ~/setup/wisecost/sql/create_database.sql
    ```

3. 在`mysql>`提示符下执行如下命令，创建`wisecost`用户（默认密码为`Wisecost~`）并为其赋予`storage`库和`wisecost`库的完全访问权限。

    ```sh
        mysql> source ~/setup/wisecost/sql/create_user.sql
    ```

4. 在控制台执行命令`mysql -h127.0.0.1 -uwisecost`，输入密码（默认密码为`Wisecost~`），登录mysql数据库。
5. 在`mysql>`提示符下执行`show database`，确认`storage`库和`wisecost`库已经创建。可以通过`select`语句（例如`select * from storage.pv`）查询库中相应的数据表确认用户的权限是否正常。
6. 至此，数据库初始化完毕。

## 部署应用

1. 通过 `kubectl apply -f ~/setup/wisecost/namespace.yaml`将如下文件应用到集群，创建名称空间`wiseinf-system`。
    {{< readfile file="wisecost/namespace.yaml" code="true" lang="yaml" >}}
1. 通过 `kubectl apply -f ~/setup/wisecost/wisecost.yaml`将如下文件应用到集群，部署应用**Wise Cost**。
    {{< readfile file="wisecost/wisecost.yaml" code="true" lang="yaml" >}}
1. 通过`kubectl port-forward svc/wisecost-ui-service 80:80`
1. 访问URL`http://localhost`，即可看到Wise Cost首页。
1. 至此，应用**Wise Cost**部署完毕。

## 下一步：导入集群

下一步，您可以添加一个集群，查看其各项成本。详见导入集群[导入阿里云集群](/docs/wisecost/import-aliyun)

## 附录

* 脚本`create_user.sql`
    {{< readfile file="wisecost/sql/create_user.sql" code="true" lang="sql" >}}
* 脚本`create_database.sql`
    {{< readfile file="wisecost/sql/create_database.sql" code="true" lang="sql" >}}
