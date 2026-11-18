# Bucket per le istruzioni aggiuntive lette a runtime dal backend di Sage.
resource "google_storage_bucket" "instructions" {
  project                     = var.project_id
  name                        = "${var.resource_prefix}-instructions"
  location                    = var.region
  uniform_bucket_level_access = true
  force_destroy               = true

  depends_on = [google_project_service.apis]
}

# Permesso minimo al service account di Cloud Run per leggere istruzioni.md dal bucket.
resource "google_storage_bucket_iam_member" "sage_run_instructions_viewer" {
  bucket = google_storage_bucket.instructions.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.sage_run.email}"
}
