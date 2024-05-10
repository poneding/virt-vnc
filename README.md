# virt-vnc

[noVNC](https://github.com/novnc/noVNC) for [kubevirt](https://github.com/kubevirt/kubevirt)

此项目 fork 自 [wavezhang/virtVNC](https://github.com/wavezhang/virtVNC)，感谢原作者的贡献。

## 背景

在使用 `kubevirt` 时，我们需要为虚拟机提供 vnc 访问，以便于虚拟机的图形界面操作。`kubevirt` 默认提供了 `virtctl vnc` 命令，但是这个命令只能在本地访问虚拟机的 vnc，无法实现远程访问。

`virt-vnc` 项目提供了一种解决方案，通过部署 `noVNC` 服务，实现远程访问虚拟机。

出于虚拟机隔离访问的考虑，该项目运行时需要注入两个环境变量：

1. VM_NAMESPACE：目标 Kubevirt 虚拟机所在的命名空间；
2. VM_NAME：目标 Kubevirt 虚拟机的名称。

由此，部署起来的 virt-vnc 服务只能访问某一特定的虚拟机，但是这仍然需要通过 Kubernetes RBAC 来限制 virt-vnc 服务的访问权限。

## 部署演示

Note: 需要集群可以正常创建 Kubevirt 虚拟机。

```bash
kubectl apply -f example/cirros-vm-vnc.yaml
```

获取 virt-vnc 服务的 NodePort：

```bash
kubectl get service cirros-vnc -n test -o=jsonpath='{.spec.ports[0].nodePort}'
```

访问 vnc-virt 服务：

```txt
http://<NODE_IP>:<NODE_PORT>/index.html
```

## 最佳实践

结合 [virt-vnc-controller](https://github.com/poneding/virt-vnc-controller) 项目，自动为每个虚拟机创建单独隔离 virt-vnc 服务。
