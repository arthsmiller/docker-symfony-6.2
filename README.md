# Docker for Symfony

sample text

---

### How to clear docker stuff
**To delete all containers including its volumes use,**

`docker rm -vf $(docker ps -aq)`


**To delete all the images,**

`docker rmi -f $(docker images -aq)`
