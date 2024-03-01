FROM node:20-alpine AS build

WORKDIR /app


COPY package*.json ./


RUN npm install

COPY . .

RUN npm run build

FROM nginx:alpine


COPY --from=build /app/build  /data/www/

COPY nginx.conf /etc/nginx/nginx.conf



CMD ["nginx", "-g", "daemon off;"]