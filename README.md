Building and sending a diploma thesis from the HTL Leoben unofficially repo

# Usage

In the repo that should use this workflow create a file `.github/workflows/thesis.yml` and paste following contents into it. Do not forget to create the secrets.

```yml
name: Build and send diploma thesis

on: 
  push:
  workflow_dispatch:

jobs:
  build-and-send:
    runs-on: ubuntu-latest

    steps:
      - name: Build and send diploma thesis
        uses: bitsneak/TestingDABuild@v0.1.3
        with:
          # optional
          # if the folder where the template is pasted into and filled out has a different name than 'Diplomarbeit'
          thesis-path: DA

          # required
          smtp-server: ${{ secrets.SMTP_SERVER }}
          smtp-port: ${{ secrets.SMTP_PORT }}
          mail-address: ${{ secrets.MAIL }} # do not use school email address
          mail-address-password: ${{ secrets.MAIL_PASSWORD }} # when using gmail an app password must be used
          teams-mail: ${{ secrets.TEAMS_MAIL }}
```
