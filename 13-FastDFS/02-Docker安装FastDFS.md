## 1、使用Docker安装FastDFS

1. 使用 `docker search fastdfs` 查找 FastDFS
2. 使用 `docker pull qbanxiaoli/fastdfs` 获取 qbanxiaoli/fastdfs 的 FastDFS

> pull 时速度特别慢，可以使用阿里云镜像

3. `mkdir -p /root/docker/fastdfs` 创建映射图片服务器的本地路径
4. 启动 Docker：`docker run -d --restart=always --privileged=true --net=host --name=fastdfs -e IP=192.168.52.128 -v /root/docker/fastdfs:/var/local/fdfs qbanxiaoli/fastdfs` 地址IP根据自己的修改
5. 查看图片服务器进程 storage 以及 tracker：`netstat -luntp|grep dfs`
6. 进入 Docker 启动的图片服务器：`docker exec -it fastdfs bash`
7. 创建一个小文件：`echo "Hello FastDFS!">index.html`
8. 上传图片服务器：`fdfs_test /etc/fdfs/client.conf upload index.html`；会自动生成图片的 url
9. 退出：`exit`