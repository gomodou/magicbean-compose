# magicbean-compose

## Installation

copy and run:

```shell
/bin/bash -c "$(curl https://raw.githubusercontent.com/gomodou/magicbean-compose/main/deploy.sh)"
```

after the script is execute successfuly, you have running magicbean in docker: 

- [http://localhost:9010](http://localhost:9010)
- default username/password: `admin` / `123456`
- get a license in [https://hykpi.com/shop](https://hykpi.com/shop)

## for dev

```
brew install git-flow-avh
git flow feature start MYFEATURE
git flow feature publish MYFEATURE
git flow feature finish MYFEATURE

git flow feature pull origin MYFEATURE
git flow feature track MYFEATURE

git flow release start RELEASE [BASE]
git flow release publish RELEASE
git flow release track RELEASE
git flow release finish RELEASE


git flow hotfix start VERSION [BASENAME]
git flow hotfix finish VERSION

```
