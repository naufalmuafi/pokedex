FROM node:18-alpine AS build
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY public ./public
COPY src ./src

# Build the application
RUN npm run build

#  Start Nginx server
FROM nginx:alpine
WORKDIR /app

# Copy the build output from the previous stage
COPY --from=build /app/build /app
# COPY nginx/config/default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]