require "base64"

bucket_name = *ENV["INPUT_BUCKET"]
File.write "/GOOGLE_CREDENTIALS.json", Base64.decode64(*ENV["INPUT_SECRETS"])
`gcloud auth activate-service-account --key-file=/GOOGLE_CREDENTIALS.json`
`rm /GOOGLE_CREDENTIALS.json`
`gsutil rsync -d -c -R dags/ #{bucket_name}/dags`
`gsutil rsync -d -c -R plugins/ #{bucket_name}/plugins`

