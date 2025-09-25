FROM nginx:alpine

COPY site/ /usr/share/nginx/html

COPY site/assets/ /usr/share/nginx/html/assets

EXPOSE 80

