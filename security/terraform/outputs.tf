output "yandex_storage_object_object-1_url" {
  value = "https://${yandex_storage_bucket.filippov-netology-bucket.bucket_domain_name}/${yandex_storage_object.object-1.key}"
}

output "yandex_storage_object_index_html_url" {
  value = "https://${yandex_storage_bucket.filippov-netology-bucket.bucket_domain_name}/${yandex_storage_object.index_html.key}"
}
