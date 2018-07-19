Rsync
----

Here's an example on how to sync the content of a certain folder to a docker volume:

```
version: '3.6'
services:
  rsync:
    image: dinamic/rsync-static
    entrypoint:
      /rsync -rtRlv /source /destination
    volumes:
      - "sourceCode:/destination"
      - "/path/to/src:/source"
    privileged: true
    ulimits:
      memlock:
        soft: -1
        hard: -1
      nofile:
        soft: 524288
        hard: 524288
volumes:
  sourceCode:
```
