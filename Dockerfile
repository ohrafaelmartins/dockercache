# Base image with Elixir and Erlang installed
FROM elixir:1.15

# Update package lists and install additional tools
RUN apt-get update && apt-get install -y \
    curl \
    git \
    vlc \
    htop \
    mysql-client \
    nginx \
    python3 python3-pip \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Hex and Rebar (Elixir's build tools)
RUN mix local.hex --force && mix local.rebar --force

# Set working directory inside the container
WORKDIR /app

# Copy the project files
COPY . .

# Install dependencies (if any)
RUN mix deps.get

# Expose port for applications (adjust as needed)
EXPOSE 4000

# Command to run the application
CMD ["mix", "run"]
