### STAGE 1: Build ###

# We label our stage as ‘builder’
#FROM node:8.11.2 as builder
FROM node:6.14.4 as builder

#Cleanup
#RUN npm cache clean --force
#RUN rmdir node_modules /s /q

#RUN npm install -g typescript@2.0.10
#COPY package.json package-lock.json ./
COPY package.json package-lock.json ./


## Storing node modules on a separate layer will prevent unnecessary npm installs at each build
#RUN npm i --no-cache git && mkdir /ng-app && mv ./node_modules ./ng-app
#RUN npm i && mkdir /ng-app && cp -R ./node_modules ./ng-app
RUN npm i && mkdir /ng-app && cp -R ./node_modules ./ng-app

#RUN npm i -g @angular/cli:1.0.0


#RUN mkdir /ng-app
WORKDIR /ng-app

#RUN npm install

#RUN npm install -g @angular/cli@1.1.0

#WORKDIR /ng-app

COPY . .


#RUN npm i -g @angular/cli
#RUN npm install

#RUN npm rebuild node-sass --force

## Build the angular app in production mode and store the artifacts in dist folder
#RUN $(npm bin)/ng build --prod
RUN $(npm bin)/ng build --env prod
#RUN ng build --env prod


### STAGE 2: Setup ###

FROM nginx:1.13.6-alpine

COPY --from=builder /ng-app/dist /usr/share/nginx/html
#COPY dist /usr/share/nginx/html/
COPY start_front.sh /tmp
EXPOSE 80

# Override these two with the correct urls at runtime :)
ENV GR_BACKEND_URL "http://smartsdk-back:8080/back-sdk"
ENV GR_GRAFANA_URL "http://grafana-back:3000/dashboard/db/airquality-dashboard"
ENV GR_ALERTS_URL "http://alerts-back:8081/#"
ENV GR_ROUTINGMAP_URL "http://map-back:4200/"

CMD ["sh", "/tmp/start_front.sh"]
