# Use official lightweight Node base image
FROM node:16-alpine

# Set working directory inside container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the source code
COPY . .

# Expose port app runs on
EXPOSE 3000

# Run the app
CMD ["npm", "start"]