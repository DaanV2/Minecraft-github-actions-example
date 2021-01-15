# Create world on create tag

- [Create world on create tag](#create-world-on-create-tag)
  - [Creating the workflow:](#creating-the-workflow)

Example file: [/.github/workflows/create-world-on-create-tag.yml](../.github/workflows/create-world-on-create-tag.yml)

This work flow triggers whenever a commits is pushed to master. this count also when a pull-request is merged.
Suggest if you make a `development` branch like this repository have. you push all to that branch and whenever you need a build merge the development to master, but do not delete the branches.

---
## Creating the workflow:

1. First create a new work flow, [read here](./Create%20workflow.md)
2. For now click on: `Set up this workflow` in the Simple workflow box.
  ![image](Assets/Choose%20workflow%20template.png)
3. You will see the following screen:
  ![image](Assets/Create%20workflow%20data%20screen.png)
4. Make sure to fill out a name in the top box (first green arrow), Copy and paste the following into the big text box, removing the old text. and then once you are done (**we are not done yet!**), on the right (last green arrow) Commit the changes.

```yml
# This is a basic workflow to help you get started with Actions
name: create-world-on-push-master

# Controls when the action will run. 
on:
  # Triggers the workflow on push or pull request events but only for the master branch
  push:
    branches: [ master ]

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  # This workflow contains a single job called "build"
  build:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest

    # Steps represent a sequence of tasks that will be executed as part of the job
    steps:
      # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
      - name: Checkout code
        uses: actions/checkout@v2

      # Runs the zipping command
      - name: Zipping folder
        run: cd "Minecraft World Example"; zip -r ../world.mcworld *

      # Creates the release page
      - name: Create Release
        id: create_release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }} # This token is provided by Actions, you do not need to create your own token
        with:
          tag_name: ${{ github.ref }}
          release_name: Release ${{ github.ref }}
          body: automated release
          draft: false
          prerelease: false

      ## Uploads to the newly made release
      - name: Upload Release Asset
        id: upload-release-asset 
        uses: actions/upload-release-asset@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }} # This pulls from the CREATE RELEASE step above, referencing it's ID to get its outputs object, which include a `upload_url`. See this blog post for more info: https://jasonet.co/posts/new-features-of-github-actions/#passing-data-to-future-steps 
          asset_path: ./world.mcworld
          asset_name: world.mcworld
          asset_content_type: application/zip
```

3. Rename the folder reference in:   
`run: cd "Minecraft World Example"; zip -r ../world.mcworld *`
to whatever you want,   
for example. Let says your world + RP + BP is stored in: `<Repository Name>/Project/World/`  
Then updated the reference to: `run: cd "Project/World"; zip -r ../../world.mcworld *`

---