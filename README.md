Gissuel
-----

## Setup

- `gem install gissuel`
- Create GH token with `repo` access
`Settings` > `Developer settings` > `Personal access tokens`
- Export `GITHUB_TOKEN` token to environment

## Usage

- Run `gissuel get --label [label] --repo [repo-name] --body`

    For example, I added lines similar to the following to my `.zshrc` file

    ```
    export GITHUB_TOKEN="XXXXXXXXXXXXX"
    gissuel planned semaphoreci/semaphore
    ```
- Options are optional
  - `--repo` (`--label`) - When not specified, Gissuel will look for any issue 
  that is assigned to token owner. Otherwise, it will only look for specified repo (label).
  - `--body`  - when Gissuel is called with this option, it will show text for
  each found issue
