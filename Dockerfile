FROM node:16-alpine AS build

WORKDIR /app

COPY page-picks-frontend/package.json package-lock.json ./
RUN npm install

COPY page-picks-frontend .
RUN npm run build --prod

FROM nginx:alpine

COPY --from=build /app/dist/page-picks-frontend /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
