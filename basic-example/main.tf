resource "local_file" "file" {
  content         = "foobar"
  filename        = "${path.module}/new_file.txt"
  file_permission = "0400"
}