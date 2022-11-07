## Local Development Setup

Clone this repo by running `git clone https://github.com/sahilLikes2Code/simply-coach-assignment.git`.

Install [ruby](https://www.ruby-lang.org/en/) version `v3.1.0` which is specified inside the `.ruby-version` file.

### Setup

```bash
bin/setup
```

### Running the server
Start the server by executing either of the following commands:

```bash
bin/dev
```

### Running Tests

```bash
bin/ci
```

### Help

```bash
bin/setup help
```


## Features

1. Sign in - `/sessions/new`
2. Sign up - `/users/new`
3. Dashboard - `/` or `/tasks`
4. New Task - `/tasks/new`
5. Edit Task - `/tasks/{id}/edit`
6. Matrix Solver - `/matrices/new`
7. Matrix Solver API - `POST /matrices.json` expects JSON body `{ "matrix": "[[0, 1, 0, 1, 1, 1], [1, 1, 1, 1, 1, 1],[1, 1, 1, 0, 0, 0], [1, 1, 1, 1, 1, 1]]" }`
