FROM ubuntu:latest as HUGOINSTALL
RUN apt-get update
RUN apt-get install hugo -y
COPY . /hugosite
RUN hugo -v --source=/hugosite --destination=/hugosite/public
FROM nginx:stable-alpine
RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/old-index.html
COPY --from=HUGOINSTALL /hugosite/public/ /usr/share/nginx/html/ 
EXPOSE 80
