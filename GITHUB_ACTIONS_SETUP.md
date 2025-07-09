# GitHub Actions Setup for Docker Hub Publishing

This repository uses GitHub Actions to automatically build and push the Docker image to Docker Hub whenever changes are made to the repository.

## Setup Instructions

### 1. Configure Docker Hub Secrets

You need to add the following secrets to your GitHub repository:

1. Go to your repository on GitHub
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Add the following repository secrets:

- `DOCKER_USERNAME`: Your Docker Hub username
- `DOCKER_PASSWORD`: Your Docker Hub access token (see below for 2FA setup)

#### For Docker Hub accounts with 2FA enabled:

Since your Docker Hub account uses 2FA, you **must** use an access token instead of your password:

1. **Create a Docker Hub Access Token**:
   - Log in to [Docker Hub](https://hub.docker.com/)
   - Go to **Account Settings** → **Security**
   - Click **New Access Token**
   - Choose a descriptive name (e.g., "GitHub Actions CI")
   - Select permissions: **Read, Write, Delete** (for pushing images)
   - Click **Generate**
   - **Important**: Copy the token immediately as it won't be shown again

2. **Add the token to GitHub Secrets**:
   - Use the generated access token as the value for `DOCKER_PASSWORD`
   - Do **NOT** use your actual Docker Hub password

### 2. Workflow Triggers

The workflow is configured to run:
- On pushes to `master`, `main`, or `develop` branches
- On pull requests to `master`, `main`, or `develop` branches (build only, no push)
- Manually via the GitHub Actions interface

### 3. Tags and Versions

The workflow will automatically create the following tags:
- `latest` (only for the default branch)
- `android-28.0.3` (version tag)
- Branch-specific tags for development

### 4. Manual Trigger

You can manually trigger the workflow:
1. Go to **Actions** tab in your repository
2. Select "Build and Push Docker Image"
3. Click "Run workflow"
4. Choose the branch and click "Run workflow"

## Docker Hub Integration

The workflow also updates the Docker Hub repository description with the README.md content from this repository, keeping the documentation synchronized.

## Troubleshooting

- Ensure Docker Hub credentials are correctly set in repository secrets
- Check that the Docker Hub repository exists and you have push permissions
- Verify the workflow has the necessary permissions to access secrets

## Fix for Issue #3

This GitHub Actions workflow resolves [Issue #3](https://github.com/cuisines/gitlab-ci-react-native-android/issues/3) by automatically keeping the Docker Hub image in sync with the repository changes. 