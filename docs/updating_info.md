# Udating Info - Docker Files

## Via Docker Run/Create

* Update the image: `docker pull vinanrra/7dtd-server`
* Stop the running container: `docker stop 7dtdserver`
* Delete the container: `docker rm 7dtdserver`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your folders and settings will be preserved)
* Start the new container: `docker start 7dtdserver`
* You can also remove the old dangling images: `docker image 7dtdserver`

## Via Docker Compose

* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull 7dtdserver`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d 7dtdserver`
* You can also remove the old dangling images: `docker image prune`


# Updating Info - Game server files

## Updating existing server to new game version
To update your existing server to a new game server version you need to update the environment parameter `START_MODE` to `2` or `3` [See Start Modes](parameters.md#start-modes). 

* It is recommeneded to to revert your `START_MODE` back after a successful update.

### Via Docker Run/Create
 * Stop the running container: `docker stop 7dtdserver`
 * Delete the container: `docker rm 7dtdserver`
 * Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your folders and settings will be preserved)
 * Ensure you have changed the `START_MODE` to 3

### Via Docker Compose
* Modify your `docker-compose.yml`
* Change `START_MODE` to 3 (Update game and run)
* Run `docker-compose up` and wait for files to be updated
* Stop your server, usually CTRL+C to terminate the terminal
* Change `START_MODE` back to 1 (Run game)
* Run `docker-compose up -d` to bring your server back up
