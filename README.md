# 如何使用

## 构建镜像
```
cd dockerfiles
docker build -t $your_registry/gitlab-runner .
```

## 部署镜像
```
kubectl apply -f deployment.yaml
```
