---
categories: ["成本管理"]
tags: ["Wisecost", "API"]
title: "API文档"
linkTitle: "API文档"
weight: 10
description: >
  一站式云原生应用成本监控、管理和优化平台API文档。
resources:
- src: "**.{png,jpg}"
  title: "Image #:counter"
  params:
    byline: "Wiseinf Inc."
---

{{% pageinfo %}}
本部分描述了Wisecsost API相关文档。
{{% /pageinfo %}}

## 概述

Wisecost API主要为集群、节点和容器提供多维度的成本查询和成本分解查询。

Wisecost API主要通过HTTP的方式进行方式。其API文档请参见链接： 用户可通过Swagger Editor/Codegen等工具生成客户端代码。



## 通用参数描述

| 参数名称 | 说明 | 默认值 | 示例 |
|-----------|-----------------|-----------|-----------------|
| window | 查询窗口范围 | 无 | 1. 时间范围格式：主要用于描述绝对时间，例如2023-05-24T18%3A00%3A00%2B08%3A00%2C2023-05-25T00%3A00%3A00%2B08%3A00 <br>2. 时间表达式：1d, 1h，lastday，lastweek等 |
| align | 时间对齐，主要用于时间表达式，对当前时间进行截断，将截断后的时间作为当前时间进行时间表达式计算，当截断后的时间不变化时，其查询结果是不变化的。 | 1m | 例如1h，1m |
| step | 查询步长，此值必须小于或等于时间窗口范围 | 查询窗口window的范围 | 1d |
| resolution | Prometheus分辨率 | 2m | 2m |
| aggregate | 聚合参数，集群成本、节点成本和容器成本聚合参数取值不同 | 无 | 1. cluster: 按集群聚合。<br/>2. namespace: 按名称空间聚合<br/> 3. cluster,namespace: 按集群和名称空间进行聚合 |
| filter | 过滤参数，集群成本、节点成本和容器成本过滤参数取值不同 | 无 |  |

所有参数均采用URL编码。

## 集群成本API

### 查询集群成本

端点：/api/cluster

#### 实例1：查询集群`test1`过去1个小时的成本

请求：

```
${HOST}/api/cluster/window=1h&filter=cluster:test1`
```

响应中包括查询所在时间窗口、CPU成本、内存、存储和网络的相应成本。

```json
[
    {
        "test1": {
            "window": {
                "start": "2023-05-04T14:37:00Z",
                "end": "2023-05-04T15:37:00Z"
            },
            "start": "2023-05-04T14:37:00Z",
            "end": "2023-05-04T15:37:00Z",
            "cpuCoreHours": 0.1022572407401936,
            "cpuCoreUsageAverage": 0.0511286203700968,
            "cpuCost": 0.004876883689704125,
            "cpuLimitCost": 0.09538461343964662,
            "cpuDiscountedCost": 0.00024035371519684083,
            "cpuActualCost": 0.00024035371519684083,
            "memoryByteHours": 1970868694.0327873,
            "memoryBytesUsageAverage": 1970868694.0327873,
            "memoryCost": 0.029179973608599755,
            "memoryLimitCost": 0.06358974229309775,
            "memoryDiscountedCost": 0.0014381140729231169,
            "memoryActualCost": 0.0014381140729231169,
            "storageByteHours": 12.501899906846337,
            "networkCost": 0.0523391093881065,
            "networkDiscountedCost": 0.0026294713433894375,
            "networkActualCost": 0.0026294713433894375,
        }
    }
]
```

#### 实例2：查询集群2023年4月份的成本，以1天为步长

请求如下所示，其中， `window=2023-04-01T00%3A00%3A00%2B08%3A00%2C2023-04-30T23%3A59%3A59%2B08%3A00`是 `window=2023-04-01T00:00:00+08:00,2023-05-01T00:00:00+08:00`的URL编码，`step=1d`表示步长是1天。

```
${HOST}/api/cluster?window=2023-04-01T00%3A00%3A00%2B08%3A00%2C2023-04-30T23%3A59%3A59%2B08%3A00&step=1d
```

响应中包括每天的成本。

```json
[
  ...
     {
        "test1": {
            "window": {
                "start": "2023-04-16T00:00:00+08:00",
                "end": "2023-04-17T00:00:00+08:00"
            },
            "start": "2023-04-16T00:00:00+08:00",
            "end": "2023-04-17T00:00:00+08:00",
            "cpuCoreHours": 2.39842986589827,
            "cpuCoreUsageAverage": 0.049967288872880634,
            "cpuCost": 0.114386652810405,
            "cpuLimitCost": 2.289230722551519,
            "cpuDiscountedCost": 0.0056374641515348455,
            "cpuActualCost": 0.0056374641515348455,
            "memoryByteHours": 46971476835.98894,
            "memoryBytesUsageAverage": 1957144868.1662054,
            "memoryCost": 0.6954428057947072,
            "memoryLimitCost": 1.5261538150343459,
            "memoryDiscountedCost": 0.034274399947769485,
            "memoryActualCost": 0.034274399947769485,
            "storageByteHours": 296.0557048723639,
            "storageLimitCost": 0.38230305987834323,
            "storageCost": 0.11789896027827546,
            "storageDiscountedCost": 0.005920212076830545,
            "storageActualCost": 0.005920212076830545,
            "networkCost": 1.2561386253145561,
            "networkDiscountedCost": 0.0631073122413465,
            "networkActualCost": 0.0631073122413465
        }
    },
    {
        "test1": {
            "window": {
                "start": "2023-04-17T00:00:00+08:00",
                "end": "2023-04-18T00:00:00+08:00"
            },
            "start": "2023-04-17T00:00:00+08:00",
            "end": "2023-04-18T00:00:00+08:00",
            "cpuCoreHours": 2.4017858534989167,
            "cpuCoreUsageAverage": 0.05003720528122743,
            "cpuCost": 0.11454670760040295,
            "cpuLimitCost": 2.289230722551519,
            "cpuDiscountedCost": 0.005645352337076829,
            "cpuActualCost": 0.005645352337076829,
            "memoryByteHours": 46969022844.09973,
            "memoryBytesUsageAverage": 1957042618.5041554,
            "memoryCost": 0.6954064728726917,
            "memoryLimitCost": 1.5261538150343459,
            "memoryDiscountedCost": 0.03427260930576406,
            "memoryActualCost": 0.03427260930576406,
            "storageByteHours": 296.51888150455557,
            "storageLimitCost": 0.38230305987834323,
            "storageCost": 0.11808341219884944,
            "storageDiscountedCost": 0.005929474198270796,
            "storageActualCost": 0.005929474198270796,
            "networkCost": 1.2561386253145561,
            "networkDiscountedCost": 0.0631073122413465,
            "networkActualCost": 0.0631073122413465
        }
    },
  ...
]
```

### 查询集群成本分解

端点：/api/cluster/breakdown

> TBD

## 节点成本API

### 查询节点成本

示例：查询2023年5月21日的成本，同时以集群维度进行聚合

查询请求如下，`aggregate=cluster`表示以集群的维度进行对成本进行聚合。

```
${HOST}/api//node?window=2023-05-21T00%3A00%3A00%2B08%3A00%2C2023-05-22T00%3A00%3A00%2B08%3A00&aggregate=cluster&step=1d
```

响应如下：

```json
[
    {
        "test1": {
            "window": {
                "start": "2023-05-21T00:00:00+08:00",
                "end": "2023-05-22T00:00:00+08:00"
            },
            "start": "2023-05-21T00:00:00+08:00",
            "end": "2023-05-22T00:00:00+08:00",
            "cpuCoreHours": 10191.999645820562,
            "cpuCoreUsageAverage": 11.849338429255141,
            "cpuCost": 1398.9775682219886,
            "cpuLimitCost": 15249.214211755743,
            "cpuDiscountedCost": 381.60351525705556,
            "cpuActualCost": 28.957126887351876,
            "memoryByteHours": 75542324732065.4,
            "memoryBytesUsageAverage": 3204178398788.0137,
            "memoryCost": 1112.9733948614235,
            "memoryLimitCost": 3346.309071231689,
            "memoryDiscountedCost": 319.71875931585464,
            "memoryActualCost": 30.702726624974325,
            "gpuLimitCost": 8510.219221802927,
            "storageByteHours": 325888.80723224004,
            "storageLimitCost": 930.4165497908426,
            "storageCost": 260.05386312757275,
            "storageDiscountedCost": 5527.065766508991,
            "storageActualCost": 589.8840784941499
        }
    }
]
```

### 查询节点成本分解

> TBD

## 容器成本API

### 查询容器成本

端点：/api/cost

#### 示例1：查询过去1小时的容器成本

请求如下：

```
${HOST}/api/cost?window=1h
```

响应如下，其中，`test1/kube-system/kube-state-metrics-678c95bd66-zpxhr/kube-state-metrics/d222ea5b968281735981465d393dc140fae2fa6c82bca4ce7b0551094542b6cc`为容器键，可唯一定位集群中的容器，其集群是`test1`，名称空间是`kube-system`，Pod是`kube-state-metrics-678c95bd66-zpxhr`，容器名为`kube-state-metrics`, 容器ID是`d222ea5b968281735981465d393dc140fae2fa6c82bca4ce7b0551094542b6cc`。

```json
[
  {    
    "test1/kube-system/kube-state-metrics-678c95bd66-zpxhr/kube-state-metrics/d222ea5b968281735981465d393dc140fae2fa6c82bca4ce7b0551094542b6cc": {
    "window": {
      "start": "2023-05-21T00:00:00+08:00",
      "end": "2023-05-22T00:00:00+08:00"
    },
    "start": "2023-05-21T00:00:00+08:00",
    "end": "2023-05-22T00:00:00+08:00",
    "cpuCoreHours": 0.0006655009861111111,
    "cpuCoreUsageAverage": 0.0006655009861111111,
    "cpuCost": 0.00018150026893939394,
    "memoryByteHours": 30465849.806451615,
    "memoryByteUsageAverage": 30465849.806451615,
    "memoryCost": 0.0025794121526902724,
    "networkTransferBytes": 155958130.4459916,
    "networkReceiveBytes": 7025546.93011364,
    "networkCost": 0.12143230242737027
  },
  ...
]
```

#### 示例2：查询过去1小时的成本并按名称空间聚合

请求如下，`aggregate=cluster,namespace`表示按照集群`cluster`和名称空间`namespace`两个维度聚合。

```
${HOST}/api/cost?window=1h&aggregate=cluster,namespace
```

响应如下，以键值对形式表示，其中`test1/default`和`test1/wiseinf-system`为聚合后的集群和名称空间构成（例如，`test1/wiseinf-system`表示集群是`test1`，名称空间是`wiseinf-system`），其值中为查询时间窗口以及CPU、内存、存储、网络的成本。

```json
[
        {
            "test1/default": {
                "window": {
                    "start": "2023-05-16T03:12:00Z",
                    "end": "2023-05-17T03:12:00Z"
                },
                "start": "2023-05-16T03:12:00Z",
                "end": "2023-05-17T03:12:00Z",
                "cpuCoreHours": 110.37890957267645,
                "cpuCoreUsageAverage": 4.599121232194852,
                "cpuCost": 14.534367730634747,
                "cpuDiscountedCost": 5.087019014821965,
                "memoryByteHours": 855736964377.1166,
                "memoryBytesUsageAverage": 35655706849.04652,
                "memoryCost": 16.161382539369775,
                "memoryDiscountedCost": 5.656134320229584,
                "storageByteHours": 71415669997.57649,
                "storageBytesUsageAverage": 2975652916.565687,
                "storageCost": 0.03335223778525009,
                "storageDiscountedCost": 0.8787704581851865,
                "networkTransferBytes": 1719133463220.9966,
                "networkReceiveBytes": 5342028979687.877,
                "networkCost": 1436.257368277605
            },
            "test1/wiseinf-system": {
                "window": {
                    "start": "2023-05-16T03:12:00Z",
                    "end": "2023-05-17T03:12:00Z"
                },
                "start": "2023-05-16T03:12:00Z",
                "end": "2023-05-17T03:12:00Z",
                "cpuCoreHours": 0.473797171047238,
                "cpuCoreUsageAverage": 0.01974154879363492,
                "cpuCost": 0.08657493662239153,
                "cpuDiscountedCost": 0.030290465709544856,
                "memoryByteHours": 74778025427.29366,
                "memoryBytesUsageAverage": 3115751059.4705696,
                "memoryCost": 1.4158569605645943,
                "memoryDiscountedCost": 0.4953997082063547,
                "storageByteHours": 1515201139.4631371,
                "storageBytesUsageAverage": 63133380.81096403,
                "storageCost": 0.0011343806651708506,
                "storageDiscountedCost": 0.06193233856164118,
                "networkTransferBytes": 11732534100151.451,
                "networkReceiveBytes": 15567186905652.652,
                "networkCost": 7666.392896312047
            }
        }
]
```
