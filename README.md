# 如何使用

## 构建镜像
```
cd dockerfiles
docker build -t $your_registry/gitlab-runner .
```

## 部署镜像
```
kubectl apply -f clusterrolebind.yaml
kubectl apply -f deployment.yaml
```

## 说明
- 请按需修改项目文件中的image镜像地址和gitlab地址、注册token等；
- 请按需修改gitlab runner注册的tag；
