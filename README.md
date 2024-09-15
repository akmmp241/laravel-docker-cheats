# Build Image
`docker build -t <your_image_name>:<tag> .`

# Compose 
`docker compose up -d`

# Accessing Artisan
`docker compose run --rm artisan <artisan_command>`

### example
`docker compose run --rm artisan about`