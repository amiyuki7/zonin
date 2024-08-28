# zonin

## Requirements

- Flutter installed with working simulators (for now, only iOS is guaranteed to work) [[Install Flutter](https://flutter-ko.dev/get-started/install)]
- Docker [[Install Docker](https://docs.docker.com/engine/install/)]

## Setup

### With Docker

```sh
# Clone and cd
git clone https://github.com/amiyuki7/zonin.git && cd zonin
```

Copy & run this line to _**SETUP**_ the database. The `setup_rethinkdb.py` script should not be run a second time.
```sh
docker build -t zonin . && docker run -d -p 8080:8080 -p 28015:28015 --name rethink_zonin zonin && docker exec rethink_zonin python3 setup_rethinkdb.py
```

Note that for testing purposes, this script will create a default user with the login:
|email|password|
|---|---|
|admin@zonin.dev|admin888|

## Run

### With an iOS Simulator configured via Xcode

```sh
# Start the database if you haven't already
docker start rethink_zonin

# Alternatively, manually open a Simulator of choice
open -a Simulator

flutter run
```
