sed -i "s/^maxconn.*/maxconn $NUMBER_OF_CONNECTIONS/" /etc/haproxy/haproxy.cfg

sed -i "s/^timeout.*/timeout $TIMEOUT/" /etc/haproxy/haproxy.cfg

sed -i "s/^buffer-size.*/buffer-size $BUFFER_SIZE/" /etc/haproxy/haproxy.cfg