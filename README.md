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
  - `--index` - combined with above mentioned options, it will print only an issue
  under the specified ordinal number

## Examples


I want to get quick overview of issues assigned to me within `semaphoreci/semaphore` repo:
```
gissuel get --repo semaphoreci/semaphore 
```
I want to list mine issues with label planned:
```
gissuel get --label planned
```
I'd like to take a quick look at all issues withing repo `semaphoreci/semaphore` with label `planned` assigned to me
```
gissuel get --repo semaphoreci/semaphore --label planned
```
Finally, from the last list, I'd like to see description of second issue
```
gissuel get --repo semaphoreci/semaphore --label planned --index 2 --body
```
