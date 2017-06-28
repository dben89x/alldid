# README

`foreman start -f Procfile.dev` to start development server.

### Data transfer
To transfer database from staging to prod (or vice versa)...

Case 1 - If transferring to prod from staging
Case 2 - If transferring to staging from prod

Case 1:
`heroku pg:backups:capture -r staging`
`heroku pg:backups:download -r staging`

Case 2:
`heroku pg:backups:capture -r prod`
`heroku pg:backups:download -r prod`

Upload .dump file to AWS. Make the file public. Copy URL for the dump file.

Case 1:
`heroku pg:backups:restore 'YOUR_URL' -r prod`

Case 2:
`heroku pg:backups:restore 'YOUR_URL' -r staging`
