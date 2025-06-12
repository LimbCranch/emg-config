#!/bin/bash
# scripts/init_repos.sh

initialize_repo() {
    local repo=$1
    local language=$2

    cd "$repo" || exit 1

    case $language in
        "rust")
            cargo init --name emg-core
            echo "target/" >> .gitignore
            echo "Cargo.lock" >> .gitignore
            ;;
        "python")
            python -m venv venv
            echo "__pycache__/" >> .gitignore
            echo "*.pyc" >> .gitignore
            echo ".pytest_cache/" >> .gitignore
            ;;
        "kotlin")
            gradle init --type kotlin-application
            echo "build/" >> .gitignore
            echo ".gradle/" >> .gitignore
            ;;
    esac

    # Common files
    cp ../emg-config/templates/CONTRIBUTING.md .
    cp ../emg-config/templates/SECURITY.md .

    git add .
    git commit -m "feat: initial repository structure"
    git push origin main
}