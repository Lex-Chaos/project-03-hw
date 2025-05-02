# Создание сервисного аккаунта
resource "yandex_iam_service_account" "sa-hw" {
  name        = "sa-hw"
  description = "Сервис-аккаунт"
  folder_id   = var.folder_id
}

# Назначение роли admin
resource "yandex_resourcemanager_folder_iam_binding" "role-hw" {
  folder_id = var.folder_id
  role      = "admin"
  members   = [
    "serviceAccount:${yandex_iam_service_account.sa-hw.id}"
  ]
}

# Создание статического ключа
resource "yandex_iam_service_account_static_access_key" "sa_key-hw" {
  service_account_id = yandex_iam_service_account.sa-hw.id
}

# Назначение прав на использование ключа KMS
resource "yandex_resourcemanager_folder_iam_binding" "kms-role-hw" {
  folder_id = var.folder_id
  role      = "kms.keys.encrypterDecrypter"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa-hw.id}"
  ]
}