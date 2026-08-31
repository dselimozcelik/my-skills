#!/usr/bin/env bash

set -eu

install_mode="symlink"
case "${1:-}" in
  "") ;;
  --copy) install_mode="copy" ;;
  --symlink) install_mode="symlink" ;;
  -h|--help)
    echo "Usage: bash scripts/bootstrap.sh [--symlink|--copy]"
    exit 0
    ;;
  *)
    echo "Unknown option: $1" >&2
    echo "Usage: bash scripts/bootstrap.sh [--symlink|--copy]" >&2
    exit 2
    ;;
esac

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
repo_root="$(CDPATH= cd -- "$script_dir/.." && pwd)"
skills_home="${AGENT_SKILLS_HOME:-$HOME/.agents/skills}"
learning_home="${AI_LEARNING_HOME:-$HOME/.ai-learning/backend-engineering}"

mkdir -p "$skills_home"
mkdir -p "$learning_home/learner/learning-records" \
  "$learning_home/learner/sessions" \
  "$learning_home/learner/reference" \
  "$learning_home/repositories" \
  "$learning_home/active"

skills="engineering-mentor teach"

for skill_name in $skills; do
  source_path="$repo_root/skills/$skill_name"
  target_path="$skills_home/$skill_name"

  if [ ! -d "$source_path" ]; then
    echo "Missing skill source: $source_path" >&2
    exit 1
  fi

  if [ -L "$target_path" ]; then
    current_target="$(readlink "$target_path")"
    if [ "$current_target" = "$source_path" ]; then
      echo "Already linked: $target_path"
      continue
    fi
    echo "Refusing to replace existing link: $target_path -> $current_target" >&2
    exit 1
  fi

  if [ -e "$target_path" ]; then
    echo "Refusing to overwrite existing path: $target_path" >&2
    exit 1
  fi

  if [ "$install_mode" = "symlink" ]; then
    ln -s "$source_path" "$target_path"
    echo "Linked: $target_path -> $source_path"
  else
    cp -R "$source_path" "$target_path"
    echo "Copied: $target_path"
  fi
done

for template_path in "$repo_root"/learning-profile-template/learner/*.md; do
  template_name="$(basename -- "$template_path")"
  profile_path="$learning_home/learner/$template_name"
  if [ -e "$profile_path" ]; then
    echo "Preserved existing profile file: $profile_path"
  elif [ "$template_name" = "PREFERENCES.md" ] && [ -e "$learning_home/NOTES.md" ]; then
    cp "$learning_home/NOTES.md" "$profile_path"
    echo "Migrated legacy profile file: $learning_home/NOTES.md -> $profile_path"
  elif [ -e "$learning_home/$template_name" ]; then
    cp "$learning_home/$template_name" "$profile_path"
    echo "Migrated legacy profile file: $learning_home/$template_name -> $profile_path"
  else
    cp "$template_path" "$profile_path"
    echo "Created profile file: $profile_path"
  fi
done

for legacy_skill in ai-native-task-tutor diagnosing-bugs; do
  if [ -e "$skills_home/$legacy_skill" ] || [ -L "$skills_home/$legacy_skill" ]; then
    echo "Legacy skill remains installed and should be removed after review: $skills_home/$legacy_skill"
  fi
done

echo
echo "Bootstrap complete."
echo "Skills:   $skills_home"
echo "Learning: $learning_home"
echo "Restart the AI application before using the skills."
