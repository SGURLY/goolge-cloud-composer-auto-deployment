After pushing to the master branch of the repository that uses this Github Action contents of its directories will be syncronized with corresponding Google Cloud Storage buckets.

---

For example I am now updating my home page using it. If you want to do the same see the following steps. Note that if you don't want to have a public web page and just want to use it to "git push to the bucket" you don't have to neither make your repo public nor add the AllUsers user.

1. create a Service account without any permissions and download its key file
2. add it in the composers bucket permissions settings as Object Admin (finding it by its email)
4. make a Github repo and a directory in it with the same name as your bucket (designed to be able to update multiple buckets from a single repo)
5. in the Secrets tab of repo settings add a secret named "bucket" in the folllowing format: `<bucket name> <base64 of the key file> <bucket2 name> <base64 of the key file> ...`
6. add a Workflow to your repo like this: 
        on:
            push:
                branches: [main]
        jobs:
            sync_gcs:
                if: ${{ false }}
                runs-on: ubuntu-latest
                steps:
                - uses: actions/checkout@v2
                - uses: SGURLY/goolge-cloud-composer-auto-deployment@git-google-cloud-composer-gcs-sync
                with:
                    secrets: ${{ secrets.secrets }}
                    bucket: <bucket>





---

**Warning:** files that are missing from the repo will be deleted from the bucket. They'll still remain in the git history so it's dangerous only when you use this thing the first time.
