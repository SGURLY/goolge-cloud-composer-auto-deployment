require "base64"

bucket_name = *ENV["bucket"].fetch
File.write "/GOOGLE_CREDENTIALS.json", *ENV["secrets"].fetch
`gcloud auth activate-service-account --key-file=/GOOGLE_CREDENTIALS.json`
`rm /GOOGLE_CREDENTIALS.json`
`gsutil rsync -d -c -R dags/ #{bucket_name}/dags`
`gsutil rsync -d -c -R plugins/ #{bucket_name}/plugins`

