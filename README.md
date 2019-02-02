# Pokelmon

![Pokelmon](http://i.imgur.com/JPNfcv3.png)

Simple Elm project consuming [PokéAPI](https://pokeapi.co/).

[Demo](http://pokelmon.surge.sh/).

## Getting Started

Elm version: 0.18

- Assuming you already have Elm installed (otherwise check the [official install guide](http://elm-lang.org/install)).
- To run elm in Docker: `alias elm='docker run -it --rm -v "$(pwd):/code" -w "/code" -e "HOME=/tmp" -u $UID:$GID -p 8000:8000 codesimple/elm:0.18'`

```sh
$ git clone https://github.com/brenopanzolini/pokelmon.git
$ cd pokelmon
```

Then install dependencies:

```sh
$ elm-package install
```

## Running the Project

You can start the project by running:

```
$ yarn start
```

This will execute *elm-reactor* and you can access the project in http://localhost:8000.

## Building the Project

You can build the project by running:

```
$ yarn build
```

This will generate the compiled files in *dist/built* folder.
