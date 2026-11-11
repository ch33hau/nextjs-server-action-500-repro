#!/bin/sh
# Run against `next build && next start` (default http://localhost:3000).
H="${1:-http://localhost:3000}"
P="$H/any-page"

status() { curl -s -o /dev/null -w '%{http_code}' "$@"; }

echo "Body cannot be parsed (expected 400):"
echo "  no boundary:            $(status -X POST -H 'Content-Type: multipart/form-data' --data 'junk' "$P")"
echo "  boundary, junk body:    $(status -X POST -H 'Content-Type: multipart/form-data; boundary=x' --data 'junk' "$P")"
echo "  part without name:      $(printf -- '--x\r\nContent-Disposition: form-data\r\n\r\nv\r\n--x--\r\n' | status -X POST -H 'Content-Type: multipart/form-data; boundary=x' --data-binary @- "$P")"
echo "Origin does not match the host (expected 403):"
echo "  Origin: null:           $(status -X POST -H 'Origin: null' -F 'a=b' "$P")"
echo "  foreign Origin:         $(status -X POST -H 'Origin: https://evil.example' -F 'a=b' "$P")"
echo "  fetch action, foreign:  $(status -X POST -H 'Origin: https://evil.example' -H 'Next-Action: 00' -H 'Content-Type: text/plain' --data '[]' "$P")"
echo "Control, unknown action (already 400 since 16.4):"
echo "  valid body, no action:  $(status -X POST -F 'a=b' "$P")"
