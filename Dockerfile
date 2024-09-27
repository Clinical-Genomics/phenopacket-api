FROM node:22-alpine as base
# Create app directory
WORKDIR /usr/src/app
COPY package*.json ./
COPY tsconfig.json ./
RUN npm install
COPY src src

# begin production build
FROM base as build-stage
RUN npm run build

# # stage 2 - copy from buildstage to "prod image"
FROM node:22-alpine as production-stage
WORKDIR /app
RUN chown node:node .
USER node
COPY package*.json ./
COPY tsconfig.json ./
COPY apischema.json ./

RUN npm ci --only=production
COPY --from=build-stage /usr/src/app/dist ./dist

COPY ./phenopacket-schema ./phenopacket-schema

EXPOSE 3000
CMD ["node", "/app/dist/index.js"]
