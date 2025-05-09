# ---- Build Stage ----
FROM node:16 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# (Optional: Run tests or build steps here)

# ---- Production Stage ----
FROM node:16-alpine
WORKDIR /app
# Copy only production dependencies from builder
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/app.js .
COPY --from=builder /app/package.json .

EXPOSE 3000
CMD ["node", "app.js"]
