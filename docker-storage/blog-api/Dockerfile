# First stage: Build the application
FROM node:18-alpine AS build

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the app's source code
COPY . .

# Second stage: Create the production image
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Copy dependencies from the build stage
COPY --from=build /app /app

# Expose the port
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
