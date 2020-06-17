COUNT=20

siege -r $COUNT -c 50 -v http://server-product-catalog-dev.apps.cluster.ocplab.com/api/product &
siege -r $COUNT -c 50 -v http://server-product-catalog-dev.apps.cluster.ocplab.com/api/product/count &
siege -r $COUNT -c 50 -v http://server-product-catalog-dev.apps.cluster.ocplab.com/api/category &
