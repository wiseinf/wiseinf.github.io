FROM klakegg/hugo:ext-alpine

RUN apk add git && \
  git config --global --add safe.directory /src

WORKDIR /usr/src/wiseinf-site

COPY . .

RUN hugo -D

# release
FROM nginx:stable-alpine as release

COPY --from=build /usr/src/wiseinf-site/docs /usr/share/nginx/html

WORKDIR /usr/share/nginx/html
EXPOSE 80

CMD ["/bin/sh", "-c", "nginx -g \"daemon off;\""]