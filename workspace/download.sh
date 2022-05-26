set -e
set -x

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 VERSION"
    exit 1
fi
INPUT_FILE="magicbean-2.6.4.tar.gz"
VERSION="$1"
rm -f $INPUT_FILE
RELEASE_DATA=$(curl -H "Authorization: token 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" https://api.github.com/repos/gomodou/mb-backend/releases/tags/$VERSION)
ASSET_ID=$(echo $RELEASE_DATA | jq -r ".assets | map(select(.name == \"${INPUT_FILE}\"))[0].id")
curl \
  -J \
  -L \
  -H "Accept: application/octet-stream" \
  -H "Authorization: token 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" \
  "https://api.github.com/repos/gomodou/mb-backend/releases/assets/$ASSET_ID"\
  --create-dirs \
  -o "$INPUT_FILE"
