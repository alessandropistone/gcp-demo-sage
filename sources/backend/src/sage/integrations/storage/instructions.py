"""Read additional prompt instructions from Google Cloud Storage at request time."""

from google.cloud import storage

from sage.config import get_app_config


def fetch_additional_instructions() -> str:
    """Download the instructions markdown file from GCS on every request."""
    config = get_app_config()
    if not config.instructions_bucket:
        return ""

    client = storage.Client(project=config.project_id)
    bucket = client.bucket(config.instructions_bucket)
    blob = bucket.blob(config.instructions_blob)
    if not blob.exists():
        return ""
    return blob.download_as_text(encoding="utf-8").strip()
