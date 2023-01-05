---
categories: ["成本管理"]
tags: ["Wisecost", "阿里云"]
title: "导入阿里云集群"
linkTitle: "导入阿里云集群"
weight: 2
description: >
  本节描述导入阿里云集群的详细步骤.
resources:
- src: "**.{png,jpg}"
  title: "Image #:counter"
  params:
    byline: "Wiseinf Inc."
---

{{% pageinfo %}}
本节描述导入阿里云集群的详细步骤。
{{% /pageinfo %}}

1. 完成Wisecost安装之后，登录系统，选择“概览”，可见`概览页面`，

{{< imgproc import-aliyun-01 Fill "900x414" >}}
概览页面
{{< /imgproc >}}

2. 在“导入阿里云集群-设置阿里云访问凭据页面”设置`Access Key`和`Access Key Secret`，`Access Key`和`Access Key Secret`可从阿里云获得，具体请参考[创建Access Key](https://help.aliyun.com/document_detail/116401.htm)。设置完成`Access Key`和`Access Key Secret`后，点击下一步。系统完成验证`Access Key`和`Access Key Secret`的正确性后，进入“导入阿里云集群-Kubernetes集群及访问设置页面”。

> 在“导入阿里云集群-设置阿里云访问凭据页面”，也可以选择“使用已有凭据”，选择一个已经存在的凭据。

{{< imgproc import-aliyun-02 Fill "900x414" >}}
导入阿里云集群-设置阿里云访问凭据页面
{{< /imgproc >}}

3. 在“导入阿里云集群-Kubernetes集群及访问设置页面”，可以选择`托管集群`，也可以选择`自建集群`。下面以`自建集群`为例，说明相应的参数。完成参数设置后点击`下一步`，系统完成参数正确性验证后，进入“导入阿里云集群-设置Prometheus访问页面”

| 参数 | 说明 |
| ---  | --- |
| 集群地域 | 集群地域指集群所部署的地域，务必正确制定地域，否则会导致集群无法访问。具体请参见[地域和可用区](https://help.aliyun.com/document_detail/40654.htm) | 
| 集群ID | 唯一标识ID，用于唯一的标识一个集群 |
| 集群名称 | 集群名称 | 
| 描述 | 集群相关描述 | 
| Kubeconfig | 访问集群的Kubeconfig文件，需开通对于集群的只读访问权限。不正确的设置会导致无法访问集群或者获取集群中的对象出错。 | 


{{< imgproc import-aliyun-03 Fill "900x414" >}}
导入阿里云集群-Kubernetes集群及访问设置页面
{{< /imgproc >}}

4. 在“导入阿里云集群-设置Prometheus访问页面”，设置Prometheus访问地址。完成参数设置后点击`下一步`，进入`导入阿里云集群-导入页面`。

{{< imgproc import-aliyun-04 Fill "900x414" >}}
导入阿里云集群-设置Prometheus访问页面
{{< /imgproc >}}

5. 在`导入阿里云集群-导入页面`点击`导入`按钮，系统提交完信息后，显示`导入阿里云集群-导入成功页面`。至此，阿里云集群已经导入成功。

{{< imgproc import-aliyun-05 Fill "900x414" >}}
导入阿里云集群-导入成功页面
{{< /imgproc >}}

6. 返回“概览页”，可以在列表中看到已经导入的集群。

{{< imgproc import-aliyun-06 Fill "900x414" >}}
概览页-已导入阿里云集群
{{< /imgproc >}}

7. 在完成集群导入之后，可以进入“集群”和“成本”标签栏，查看该集群的总体整体以及相应的名称空间的成本。