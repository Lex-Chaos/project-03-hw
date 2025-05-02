resource "yandex_kms_symmetric_key" "bucket-key" {
  name              = "bucket-encryption-key"
  description       = "KMS key for bucket encryption"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" # 1 год
}