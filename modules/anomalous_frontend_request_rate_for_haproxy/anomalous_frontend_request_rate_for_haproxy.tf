resource "shoreline_notebook" "anomalous_frontend_request_rate_for_haproxy" {
  name       = "anomalous_frontend_request_rate_for_haproxy"
  data       = file("${path.module}/data/anomalous_frontend_request_rate_for_haproxy.json")
  depends_on = [shoreline_action.invoke_cfg_update_haproxy]
}

resource "shoreline_file" "cfg_update_haproxy" {
  name             = "cfg_update_haproxy"
  input_file       = "${path.module}/data/cfg_update_haproxy.sh"
  md5              = filemd5("${path.module}/data/cfg_update_haproxy.sh")
  description      = "Update HAProxy configuration file to adjust max number of connections, timeout, and buffer size."
  destination_path = "/agent/scripts/cfg_update_haproxy.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_cfg_update_haproxy" {
  name        = "invoke_cfg_update_haproxy"
  description = "Update HAProxy configuration file to adjust max number of connections, timeout, and buffer size."
  command     = "`chmod +x /agent/scripts/cfg_update_haproxy.sh && /agent/scripts/cfg_update_haproxy.sh`"
  params      = ["NUMBER_OF_CONNECTIONS","BUFFER_SIZE","TIMEOUT"]
  file_deps   = ["cfg_update_haproxy"]
  enabled     = true
  depends_on  = [shoreline_file.cfg_update_haproxy]
}

