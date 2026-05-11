npx() {
  op run --env-file="${HOME}/.config/npm/secrets.env" -- npx "$@"
}
