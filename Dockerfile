# Base image with Elixir and Erlang installed
FROM elixir:1.15

# Install Hex and Rebar (Elixir's build tools)
RUN mix local.hex --force && mix local.rebar --force

# Set working directory inside the container
WORKDIR /app

# Copy the project files
COPY . .

# Install dependencies (if any)
RUN mix deps.get

# Command to run the application
CMD ["mix", "run"]
