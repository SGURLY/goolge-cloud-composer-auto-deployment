require "base64"

Dir[?*].each do |bucket|
  next unless File.directory? bucket
  File.write "/GOOGLE_CREDENTIALS.json", Base64.decode64(Hash[*ENV["INPUT_SECRETS"].split].fetch bucket)
  `gcloud auth activate-service-account --key-file=/GOOGLE_CREDENTIALS.json`
  `rm /GOOGLE_CREDENTIALS.json`
  `gsutil rsync -d -c -R dags/ #{bucket}/dags`
  `gsutil rsync -d -c -R plugins/ #{bucket}/plugins`
end
