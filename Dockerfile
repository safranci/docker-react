# existing docker image as base image
FROM node:alpine as builder

#working dir
WORKDIR /usr/app

# Download and install dependencies
COPY ./package.json ./
RUN npm install

# COPY rest of the source files
COPY ./ ./

# RUN build command
CMD ["npm", "run", "build"]


######### Start next phase #########

FROM nginx
EXPOSE 80

#copy build folder builder phase into current phase nginx hosting folder
COPY --from=builder /usr/app/build /usr/share/nginx/html

#RUN nginx: default start command in this image will start nginx



