flutter build web --web-renderer canvaskit --release
docker build -f DockerFile -t patricktslee/uat-anchk-org:concert .   
docker push patricktslee/uat-anchk-org:concert        

flutter build web --web-renderer canvaskit --release
docker build -f DockerFile -t patricktslee/www-anchk-org:1.1.3 .
docker push patricktslee/www-anchk-org:1.1.3

flutter build web --web-renderer canvaskit --release
docker build -f DockerFile -t patricktslee/uat-anchk-org:1.1.2 .
docker push patricktslee/uat-anchk-org:1.1.2

docker tag patricktslee/uat-anchk-org:cloud registry.heroku.com/uat-anchkorg-cloud/web
docker push registry.heroku.com/uat-anchkorg-cloud/web
heroku container:release web --app=uat-anchkorg-cloud

flutter build web --web-renderer canvaskit --release
docker build -f DockerFile -t patricktslee/www-anchk-org:1.2.10 .
docker push patricktslee/www-anchk-org:1.2.10