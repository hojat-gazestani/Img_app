# Img_app
* Microservice project

```bash
git clone https://github.com/hojat-gazestani/Img_app.git && cd Img_app
source img/bin/activate

cd img_project
docker build -t img_app .
docker run -d --hostname ImgAPP30 -p 8030:8003 img_app
docker run -d --hostname ImgAPP31 -p 8031:8003 img_app
docker run -d --hostname ImgAPP32 -p 8032:8003 img_app
```
