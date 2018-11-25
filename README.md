Gissuel
-----

## Setup

- `hub clone mimimalizam/gissuel && bundle install`
- Create GH token with `repo` access
`Settings` > `Developer settings` > `Personal access tokens`
- Export `GITHUB_TOKEN` token to environment
- Run `gissuel/issues.rb [label] [repo-name]`

    For example, I added lines similar to the following to my `.zshrc` file

    ```
    export GITHUB_TOKEN="XXXXXXXXXXXXX"
    gissuel/issues.rb "planned" "semaphoreci/semaphore"
    ```
