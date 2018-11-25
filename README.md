Gissuel
-----

## Setup

- `gem install gissuel`
- Create GH token with `repo` access
`Settings` > `Developer settings` > `Personal access tokens`
- Export `GITHUB_TOKEN` token to environment

## Usage

- Run `gissuel get --label [label] --repo [repo-name]`

    For example, I added lines similar to the following to my `.zshrc` file

    ```
    export GITHUB_TOKEN="XXXXXXXXXXXXX"
    gissuel planned semaphoreci/semaphore
    ```
- Options `--label` and `--repo` are optional
