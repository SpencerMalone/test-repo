# test-repo 

This repository was used to test if there are timing issues between PRs and the "contents" GH API.

## What's the point of this?
To prove that GH is firing webhooks before the app (or at least the contents API) is ready to deal with merges. IMO the behavior should be that it holds off on the webhook until it can actually give an example of what a merge would look like.

## Steps:
1) Run the sinatra app (`bundle exec ruby app.rb`)
2) In another terminal session, use ngrok to expose a local service (`ngrok http 4567`)
3) Add the ngrok endpoint as your target for a webhook with pull requests enabled (ex: `http://5d731f3a.ngrok.io/ghevent` as your webhook target)
4) Modify test-contents for your own repo, and pass in a personal auth token as the first argument. (`./test-contents <personal auth here>`)

## What will happen?:
1) test-contents will create a file, push it to a new branch, and open a PR in a very short period.
2) A webhook will fire back to your local ruby service
3) It'll post back to the contents API, looking for a Jenkinsfile with the ref of... refs/pull/PRID/merge
4) That ref won't exist.

If you add a sleep between when sinatra gets the webhook and when it calls back to GH, then the whole thing will succeed.


