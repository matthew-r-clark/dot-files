#!/usr/bin/env bash

security find-generic-password -a "$USER" -s claude-api-key -w
# security find-generic-password -a "$USER" -s open-ai-api-key -w
