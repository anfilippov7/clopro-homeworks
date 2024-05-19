// Create SA
resource "yandex_iam_service_account" "sa-bucket" {
    name      = "sa-for-bucket"
}

// Grant permissions
resource "yandex_resourcemanager_folder_iam_member" "bucket-editor" {
    folder_id = var.folder_id
    role      = "storage.editor"
    member    = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
    depends_on = [yandex_iam_service_account.sa-bucket]
}

// Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
    service_account_id = yandex_iam_service_account.sa-bucket.id
    description        = "static access key for bucket"
    depends_on = [yandex_iam_service_account.sa-bucket]
}

// Create bucket-key
resource "yandex_kms_symmetric_key" "bucket-key" {
  name = "bucket-key"
  description       = "Key for object storage encryption"
  default_algorithm = "AES_128" # Алгоритм шифрования. Возможные значения: AES-128, AES-192 или AES-256.
  rotation_period   = "8760h"   # 1 год. Период ротации (частота смены версии ключа по умолчанию).
}


// Use keys to create bucket
resource "yandex_storage_bucket" "filippov-netology-bucket" {
    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    depends_on = [yandex_iam_service_account_static_access_key.sa-static-key]
    bucket = "filippov-netology-bucket"
    acl    = "public-read"
 
    server_side_encryption_configuration {
      rule {
        apply_server_side_encryption_by_default {
          kms_master_key_id = yandex_kms_symmetric_key.bucket-key.id
          sse_algorithm     = "aws:kms"
      }
    }
  }   
}

// Add picture to bucket
resource "yandex_storage_object" "object-1" {
    depends_on = [yandex_iam_service_account_static_access_key.sa-static-key]
    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    bucket = yandex_storage_bucket.filippov-netology-bucket.bucket
    key = "test_pic.jpg"
    content_type = "image/jpeg"
    source = "data/test_pic.jpg"
    acl    = "public-read"
}


resource "local_file" "index_html" {
  content = templatefile("${abspath(path.module)}/web-app.tftpl",
    {
      bucket = yandex_storage_bucket.filippov-netology-bucket
      object = yandex_storage_object.object-1
    }
  )
  filename = "${abspath(path.module)}/../data/index.html"
}

resource "yandex_storage_object" "index_html" {
    depends_on = [yandex_iam_service_account_static_access_key.sa-static-key]
    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    bucket = yandex_storage_bucket.filippov-netology-bucket.bucket
    key = "index.html"
    source = local_file.index_html.filename
    acl    = "public-read"
}
